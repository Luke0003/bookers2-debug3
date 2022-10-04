class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id) #ログインしているユーザの所属しているルームIDの配列
    user_rooms = @user.user_rooms.find_by(room_id: rooms) #取得したユーザがログインしたユーザと同じルームに所属しているか
    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    @chat = Chat.new(room_id: @room.id)
    @chats = @room.chats.all
  end

  def create
    @chat = current_user.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private
    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end
end
