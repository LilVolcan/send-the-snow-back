class ResortsController < ApplicationController

    def index
        resorts = Resort.all 

        render json: ResortSerializer.new(resorts).serialized_json
    end

    def filter
        #filters out any resorts that are not yet open
        open_resorts = Resort.all.select{|resort| resort.conditions[0][:area_open] > "0"}

        #sorts based on most accum. snowfall for "all" or by "state"
        if params[:state_id] == "all"
            sorted_resorts = open_resorts.sort{|a,b| (b.conditions[0][:past_24_hour].to_i + b.conditions[0][:next_5_day_snow].to_i) <=> (a.conditions[0][:past_24_hour].to_i + a.conditions[0][:next_5_day_snow].to_i)}
        else 
            resorts = open_resorts.select{ |resort| resort[:state_id] == params[:state_id].to_i}
            sorted_resorts = resorts.sort{|a,b| (b.conditions[0][:past_24_hour].to_i + b.conditions[0][:next_5_day_snow].to_i) <=> (a.conditions[0][:past_24_hour].to_i + a.conditions[0][:next_5_day_snow].to_i)}
        end 
        #slices top five results
        top_five = sorted_resorts.slice(0,5) 
     
        render json: ResortSerializer.new(top_five).serialized_json
    end 

end


  # def filter
    #     if params[:state_id] == "all"
    #         resorts = Resort.all
    #     else 
    #         resorts = Resort.all.select{ |resort| resort[:state_id] == params[:state_id].to_i}
    #     end 
    #     # byebug
    #     if params[:filter] == "past_24_hour"
    #         sorted_resorts = resorts.sort{|a,b| b.conditions[0][:past_24_hour].to_i <=> a.conditions[0][:past_24_hour].to_i} 
    #     else 
    #         sorted_resorts = resorts.sort{|a,b| b.conditions[0][:next_5_day_snow].to_i <=> a.conditions[0][:next_5_day_snow].to_i}
    #     end 
    #     top_five = sorted_resorts.slice(0,5) 
    #     render json: ResortSerializer.new(top_five).serialized_json
    # end 