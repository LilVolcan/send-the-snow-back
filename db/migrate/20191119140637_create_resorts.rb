class CreateResorts < ActiveRecord::Migration[6.0]
  def change
    create_table :resorts do |t|
      t.string :name
      t.integer :state_id
      t.string :base_elevation
      t.string :summit_elevation
      t.string :icon
      t.string :image_url
      t.string :latitude
      t.string :longitude
      t.string :resort_link
      
      t.timestamps
    end
  end
end
