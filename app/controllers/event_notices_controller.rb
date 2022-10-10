class EventNoticesController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
  end

  def create
    @group = Group.find(params[:group_id])
    @title = params[:title]
    @content = params[:content]

    EventMailer.send_notification(@group, @title, @content).deliver_now

    render :sent
  end

  def sent
    redirect_to group_path(params[:group_id])
  end

end
