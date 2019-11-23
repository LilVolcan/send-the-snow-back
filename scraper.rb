require 'nokogiri'
require 'httparty'
require 'byebug'
require_relative 'config/environment'
# require 'environment.rb'

# State.create(name: "Colorado")
# State.create(name: "California")
# State.create(name: "Wyoming")
# State.create(name: "Idaho")
# State.create(name: "Maine")
# State.create(name:"Montana")
# State.create(name: "New York")
# State.create(name: "North Carolina")
# State.create(name:"Pennsylvania")
# State.create(name: "Utah")
# State.create(name: "Vermont")
# State.create(name:"Washington")




# states = ["CO", "CA", "WY", "ID", "ME", "MT", "NY", "NC", "PA", "UT", "VT", "WA"]

# =======================================================================================
# ========================================================================================

# def resort_scraper
# states = ["CO", "CA", "WY", "ID", "ME", "MT", "NY", "NC", "PA", "UT", "VT", "WA"]
#     states.map do |state|
#         url = "https://opensnow.com/state/#{state}#forecasts"
#         unparsed_page = HTTParty.get(url)
#         parsed_page = Nokogiri::HTML(unparsed_page)
#         resorts_array = Array.new
#         all_resorts = parsed_page.css('div.compare-item')
#         all_resorts.each do |resort|
#             resort = {
#                 state_id: states.index(state) + 1, 
#                 name: resort.css('div.title-location').text
#             }
#             resorts_array << resort
#         end 
#         resorts_array.each do |resort|
#             Resort.create(resort)
#             puts "#1: creating #{resort[:name]}" 
#         end 
#     end
# end 

# resort_scraper

# ======================================================================================
# def conditions_scraper
#     states = ["CO", "CA", "WY", "ID", "ME", "MT", "NY", "NC", "PA", "UT", "VT", "WA"]
#     states.each_with_index do |state, index|
#         url = "https://opensnow.com/state/#{state}#forecasts"
#         unparsed_page = HTTParty.get(url)
#         parsed_page = Nokogiri::HTML(unparsed_page)
#         conditions_array = Array.new
#         resort_data = parsed_page.css('div.compare-item') 
#         resort_data.each do |resort|
#             resort_conditions = { 
#                 next_day_snow: resort.css('div.data-box').children[1].text.scan(/\d/).join(''),
#                 next_5_day_snow: resort.css('div.data-box').children[6].text.scan(/\d/).join(''),
#                 past_24_hour: resort.css('div.data-box').children[16].text.scan(/\d/).join(''),
#                 base_depth: resort.css('div.data-box').children[21].text.scan(/\d/).join(''),
#                 area_open: resort.css('div.data-box').children[26].text.scan(/\d/).join('')
#             }
#             resort_name = resort.css('div.title-location').text
#             found_resort_id = index + 1
#             # puts index
#             resort_hash = {resort_id: found_resort_id} 
#             conditions = resort_hash.merge(resort_conditions)
#             conditions_array << conditions
#         end 
#         conditions_array
#         conditions_array.each do |resort_conditions|
#             Condition.create(resort_conditions)
#             puts "creating #{resort_conditions[:resort_id]}" 
#         end 
#     end
# end 
# conditions_scraper
# =========================================================================================

# ============================================================================

# FITNESS SCRAPER

# def scraper1
#     url = 'https://www.snow-forecast.com/countries/USA-Colorado/resorts'
#     unparsed_page = HTTParty.get(url)
#     parsed_page = Nokogiri::HTML(unparsed_page)
#     exercises = Array.new 
#     exercise_list = parsed_page.css('div.shadow.card') #452 exercises count (versus #598 as seen on website)
#     exercise_list.each do |exercise_listing|
#         exercise = { #hash of each exercise
#             exercise_name: exercise_listing.css('p').text, #renders name of exercise
#             image_url: exercise_listing.css('img')[1].attributes["src"].value, #renders the exercise image url
#             page_url: "https://sworkit.com" + exercise_listing.css('a')[0].attributes["href"].value
#         }
#         exercises << exercise 
#     end 
#     index = 0 
#     exercises.each do |each_exercise|
#         ex_unparsed_page = HTTParty.get(each_exercise[:page_url])
#         ex_parsed_page = Nokogiri::HTML(ex_unparsed_page)
#         exercise_details = ex_parsed_page.css('div.shadow.card.exercise-card')
#         exercise = {
#             exercise_difficulty: exercise_details.css('p')[0] ? exercise_details.css('p')[0].text : "no information",
#             exercise_impact_level: exercise_details.css('p')[1] ? exercise_details.css('p')[1].text : "no information",
#             target_body_parts: exercise_details.css('p')[2] ? exercise_details.css('p')[2].text : "no information",
#             exercise_video: exercise_details.css('video')[0] ? exercise_details.css('video')[0].attributes['src'].value : "no video",
#             category: "Upper Body"
#         }
#         exercises[index].merge!(exercise) #pushes 4 attributes into array[index] for each exercise
#         Exercise.create(exercises[index]) #creates the full exercise & details in the database
#         puts "#{index + 1}: creating #{each_exercise[:exercise_name]}"  # puts each_exercise
#         index += 1
#     end 
#     Exercise.category
# end 
