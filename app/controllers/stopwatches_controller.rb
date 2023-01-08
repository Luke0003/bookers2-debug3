class StopwatchesController < ApplicationController
  def new
    @stopwatch = Stopwatch.new
    @initial_value = "00:00:00"
    @stopwatches = []
    current_user.stopwatches.select do |stopwatch|
      @stopwatches << stopwatch  if 1.day.ago.all_day.cover? stopwatch.created_at
    end
  end

  def create
    @stopwatch = Stopwatch.new(user_id: current_user.id)
    @stopwatch.rehabili_time = params[:stopwatch][:rehabili_time]
    @stopwatch.save!
    redirect_to new_stopwatch_path
  end
end
