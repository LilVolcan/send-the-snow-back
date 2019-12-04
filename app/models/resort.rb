class Resort < ApplicationRecord
    has_many :conditions
    belongs_to :state

    # def resort_conditions
    #     conditions = Condition.all
    #     resorts = Resort.all
        

    # end 


end
