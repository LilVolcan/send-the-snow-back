class ResortSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :state_id, :name, :base_elevation, :summit_elevation, :icon, :image_url, :latitude, :longitude, :resort_link, :conditions

  def conditions
    object.conditions
  end
end
