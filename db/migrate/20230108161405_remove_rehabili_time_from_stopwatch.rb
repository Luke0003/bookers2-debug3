class RemoveRehabiliTimeFromStopwatch < ActiveRecord::Migration[6.1]
  def change
    remove_column :stopwatches, :rehabili_time, :time
  end
end
