class CreateConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :conditions do |t|
      t.integer :resort_id
      t.string :next_day_snow
      t.string :next_5_day_snow
      t.string :past_24_hour
      t.string :base_depth
      t.string :area_open

      t.timestamps
    end
  end
end
