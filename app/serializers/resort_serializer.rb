class ResortSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :state_id, :name, :conditions

  def conditions
    object.conditions
  end
end
