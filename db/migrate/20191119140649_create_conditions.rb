class CreateConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :conditions do |t|
      t.integer :resort_id
      t.integer :upper_depth #string?
      t.integer :lower_depth #string?
      t.string :on_piste 
      t.string :off_piste 
      t.integer :three_day_forecast #number in inches
      t.integer :six_day_forecast #number in inches
      t.integer :nine_day_forecast #number in inches
      t.string :next_day_weather #alt: rain, partly cloudy, heavy snow, etc.
      t.integer :last_snow_amount #how many inches
      t.string :last_snow_date #how long ago, ie: 8 days ago

      t.timestamps
    end
  end
end
