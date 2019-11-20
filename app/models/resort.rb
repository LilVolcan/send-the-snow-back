class Resort < ApplicationRecord
    has_many :conditions
    belongs_to :state
end
