require 'nokogiri'
require 'httparty'
require 'byebug'
require_relative 'config/environment'
# require 'environment.rb'

def conditions_scraper
    url = 'https://opensnow.com/state/CO#forecasts'
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    conditions_array = Array.new
    resort_data = parsed_page.css('div.compare-item') #data for all 30 CO resorts
    resort_data.each do |resort|
        resort_conditions = { #need to get the resort_id?????
            next_day_snow: resort.css('div.data-box').children[1].text.scan(/\d/).join(''),
            next_5_day_snow: resort.css('div.data-box').children[6].text.scan(/\d/).join(''),
            past_24_hour: resort.css('div.data-box').children[16].text.scan(/\d/).join(''),
            base_depth: resort.css('div.data-box').children[21].text.scan(/\d/).join(''),
            area_open: resort.css('div.data-box').children[26].text.scan(/\d/).join('')
        }
        resort_name = resort.css('div.title-location').text
        found_resort_id = Resort.find_by(name: resort_name).id
        resort_hash = {resort_id: found_resort_id} 
        conditions = resort_hash.merge(resort_conditions)
        conditions_array << conditions
        # byebug
    end 
    conditions_array
    conditions_array.each do |resort_conditions|
        Condition.create(resort_conditions)
        puts "creating #{resort_conditions[:next_day_snow]}" 
        byebug
    end 
    # byebug
end 

conditions_scraper

# ===========================================================================
# url = 'https://opensnow.com/state/CO#forecasts'
# resorts = parsed_page.css('div.compare-item')
# first = resorts.first
# resort_name = first.css('div.title-location').text  ===> inside of class='compare-title' === MODEL => RESORT
# next_day_snow = first.css('div.data-box').children[1].text.scan(/\d/).join('') ==> returns a string
# next_5_day_snow = first.css('div.data-box').children[6].text.scan(/\d/).join('') ==> string
# past_24_snow = first.css('div.data-box').children[16].text.scan(/\d/).join('') ==> string
# base_snow = first.css('div.data-box').children[21].text.scan(/\d/).join('') ==> string
# area_open = first.css('div.data-box').children[26].text ==> string (percentage)
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


# ==========================================================================
# snocountry.com ('https://www.snocountry.com/snow-reports/us/colorado')
# resorts = parsed_page.css('div#section-id-1570716008841')
# first = resorts.first
# name = first.css('div.resortcol-title')[0].css('a').text
# weather = first.css('div#sppb-addon-wrapper-1571170484298').css('div.sppb-addon-content').children[4].text 
# new snow = second.css('div#sppb-addon-1571170484303').css('div.sppb-addon-content').search('p')[1].text

# Base conditions (if any) =============
# add_info = first.css('div#sppb-addon-1571170484308').search('p')[1].text
# add_info_array = add_info.split(" ")
# base_depth = add_info_array.select { |n| n.include?("Base") }[0]
# ==========================================================================