class ResortsController < ApplicationController

    def index
        resorts = Resort.all 

        render json: ResortSerializer.new(resorts).serialized_json
    end

    def resort_filter
        resorts = Resort.all.select{ |resort| resort[:state_id] == params[:state_id].to_i}
        sorted_resorts = resorts.sort{|a,b| b.conditions[0][:past_24_hour].to_i <=> a.conditions[0][:past_24_hour].to_i} 
        top_five = sorted_resorts.slice(0,5) 

        render json: ResortSerializer.new(top_five).serialized_json
    end 


end
