class CreateStopwatches < ActiveRecord::Migration[6.1]
  def change
    create_table :stopwatches do |t|
      t.integer :user_id
      t.time :rehabili_time

      t.timestamps
    end
  end
end
