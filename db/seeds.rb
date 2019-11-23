require 'nokogiri'
require 'httparty'
require 'byebug'

State.create(name: "Colorado")
State.create(name: "California")
State.create(name: "Wyoming")
State.create(name: "Idaho")
State.create(name: "Maine")
State.create(name:"Montana")
State.create(name: "New York")
State.create(name: "North Carolina")
State.create(name:"Pennsylvania")
State.create(name: "Utah")
State.create(name: "Vermont")
State.create(name:"Washington")

# ========================================================================================

def resort_scraper
states = ["CO", "CA", "WY", "ID", "ME", "MT", "NY", "NC", "PA", "UT", "VT", "WA"]
    states.map do |state|
        url = "https://opensnow.com/state/#{state}#forecasts"
        unparsed_page = HTTParty.get(url)
        parsed_page = Nokogiri::HTML(unparsed_page)
        resorts_array = Array.new
        all_resorts = parsed_page.css('div.compare-item')
        all_resorts.each do |resort|
            resort = {
                state_id: states.index(state) + 1, 
                name: resort.css('div.title-location').text
            }
            resorts_array << resort
        end 
        resorts_array.each do |resort|
            Resort.create(resort)
            puts "creating #{resort[:name]}" 
        end 
    end
end 

resort_scraper

# # ======================================================================================
def conditions_scraper
    states = ["CO", "CA", "WY", "ID", "ME", "MT", "NY", "NC", "PA", "UT", "VT", "WA"]
    index = 1;
    states.each do |state|
        url = "https://opensnow.com/state/#{state}#forecasts"
        unparsed_page = HTTParty.get(url)
        parsed_page = Nokogiri::HTML(unparsed_page)
        conditions_array = Array.new
        resort_data = parsed_page.css('div.compare-item') 
        resort_data.each do |resort|
            resort_conditions = { 
                next_day_snow: resort.css('div.data-box').children[1].text.scan(/\d/).join(''),
                next_5_day_snow: resort.css('div.data-box').children[6].text.scan(/\d/).join(''),
                past_24_hour: resort.css('div.data-box').children[16].text.scan(/\d/).join(''),
                base_depth: resort.css('div.data-box').children[21].text.scan(/\d/).join(''),
                area_open: resort.css('div.data-box').children[26].text.scan(/\d/).join('')
            }
            resort_name = resort.css('div.title-location').text
            found_resort_id = index
            # puts index
            index = index + 1;
            resort_hash = {resort_id: found_resort_id} 
            conditions = resort_hash.merge(resort_conditions)
            conditions_array << conditions
        end 
        conditions_array
        conditions_array.each do |resort_conditions|
            Condition.create(resort_conditions)
            puts "creating #{resort_conditions[:resort_id]}" 
        end 
    end
end 
conditions_scraper






