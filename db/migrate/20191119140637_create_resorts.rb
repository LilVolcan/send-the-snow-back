class CreateResorts < ActiveRecord::Migration[6.0]
  def change
    create_table :resorts do |t|
      t.string :name
      t.integer :state_id
      t.string :status #is the resort open/closed - this could change and needs to be part of daily scraper
      t.string :url
      t.integer :base_elevation
      t.integer :peak_elevation
      


      t.timestamps
    end
  end
end
