class AddRehabiliTimeToStopwatch < ActiveRecord::Migration[6.1]
  def change
    add_column :stopwatches, :rehabili_time, :string
  end
end
