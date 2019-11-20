require 'nokogiri'
require 'httparty'
require 'byebug'

# State.create(name: "Colorado")

# def resort_scraper
#     url = 'https://opensnow.com/state/CO#forecasts'
#     unparsed_page = HTTParty.get(url)
#     parsed_page = Nokogiri::HTML(unparsed_page)
#     resorts_array = Array.new
#     all_resorts = parsed_page.css('div.compare-item') #data for all 30 CO resorts
#     all_resorts.each do |resort|
#         resort = {
#             state_id: 1,
#             name: resort.css('div.title-location').text
#         }
#         resorts_array << resort
#     end 
#     resorts_array.each do |resort|
#         Resort.create(resort)
#         # puts "#1: creating #{resort[:name]}" 
#     end 
# end 

# resort_scraper

# def conditions_scraper
#     url = 'https://opensnow.com/state/CO#forecasts'
#     unparsed_page = HTTParty.get(url)
#     parsed_page = Nokogiri::HTML(unparsed_page)
#     conditions_array = Array.new
#     resort_data = parsed_page.css('div.compare-item') #data for all 30 CO resorts
#     resort_data.each do |resort|
#         resort_conditions = { #need to get the resort_id?????
#             next_day_snow: resort.css('div.data-box').children[1].text.scan(/\d/).join(''),
#             next_5_day_snow: resort.css('div.data-box').children[6].text.scan(/\d/).join(''),
#             past_24_hour: resort.css('div.data-box').children[16].text.scan(/\d/).join(''),
#             base_depth: resort.css('div.data-box').children[21].text.scan(/\d/).join(''),
#             area_open: resort.css('div.data-box').children[26].text.scan(/\d/).join('')
#         }
#         resort_name = resort.css('div.title-location').text
#         found_resort_id = Resort.find_by(name: resort_name).id
#         resort_hash = {resort_id: found_resort_id} 
#         conditions = resort_hash.merge(resort_conditions)
#         conditions_array << conditions
#         # byebug
#     end 
#     conditions_array
#     conditions_array.each do |resort_conditions|
#         Condition.create(resort_conditions)
#         puts "creating #{resort_conditions[:resort_id]}" 
#         # byebug
#     end 
#     # byebug
# end 

# conditions_scraper