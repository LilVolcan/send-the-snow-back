require 'nokogiri'
require 'httparty'
require 'byebug'

State.create(name: "Colorado")
State.create(name: "California")
State.create(name: "Wyoming")
State.create(name: "Idaho")
State.create(name:"Montana")
State.create(name: "New York")
State.create(name: "Utah")
State.create(name: "Vermont")
State.create(name:"Washington")

# # TO ADD MORE STATES, CREATE ABOVE, AND THEN ADD TO EACH STATES ARRAY BELOW

# # # ========================================================================================

def resort_scraper
states = ["CO", "CA", "WY", "ID", "MT", "NY", "UT", "VT", "WA"]
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

# # # # ======================================================================================
def conditions_scraper
    states = ["CO", "CA", "WY", "ID", "MT", "NY", "UT", "VT", "WA"]
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

# =================================================================================================================

arapahoe = Resort.find_or_initialize_by(id: 1)
arapahoe.base_elevation = "10,780"
arapahoe.summit_elevation = "13,050"
arapahoe.icon = "https://lift.opensnow.com/location-logos/arapahoebasin.png"
arapahoe.image_url = "https://snowbrains.com/wp-content/uploads/2019/02/52161709_10161313214565332_1568069968241623040_o.jpg"
arapahoe.latitude = "39.642850"
arapahoe.longitude = "-105.871971"
arapahoe.resort_link = "http://www.arapahoebasin.com"
arapahoe.save!


aspen_highlands = Resort.find_or_initialize_by(id: 2)
aspen_highlands.base_elevation = "8,104"
aspen_highlands.summit_elevation = "12,510"
aspen_highlands.icon = "https://lift.opensnow.com/location-logos/aspenmountain.png"
aspen_highlands.image_url = "https://www.skimag.com/.image/t_share/MTU4NTY1NjA4MjI3NjEyMDA0/ski1018-rg-aspen-s.jpg"
aspen_highlands.latitude = "39.186005"
aspen_highlands.longitude = "-106.818454"
aspen_highlands.resort_link = "http://www.aspensnowmass.com"
aspen_highlands.save!


aspen_mountain = Resort.find_or_initialize_by(id: 3)
aspen_mountain.base_elevation = "8,104"
aspen_mountain.summit_elevation = "12,510"
aspen_mountain.icon = "https://lift.opensnow.com/location-logos/aspenmountain.png"
aspen_mountain.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/12/57/f0/f2/snowmass-village-at-night.jpg"
aspen_mountain.latitude = "39.186005"
aspen_mountain.longitude = "-106.818454"
aspen_mountain.resort_link = "http://www.aspensnowmass.com"
aspen_mountain.save!

beaver_creek = Resort.find_or_initialize_by(id: 4)
beaver_creek.base_elevation = "8,100"
beaver_creek.summit_elevation = "11,440"
beaver_creek.icon = "https://lift.opensnow.com/location-logos/beavercreek.png"
beaver_creek.image_url = "https://www.lechzuers.com/app/uploads/2018/11/d9jgfpb-1200x750.jpg"
beaver_creek.latitude = "39.603928"
beaver_creek.longitude = "-106.516699"
beaver_creek.resort_link = "http://www.beavercreek.com"
beaver_creek.save!

berthoud_pass= Resort.find_or_initialize_by(id: 5)
berthoud_pass.base_elevation = "11,022"
berthoud_pass.summit_elevation = "12,015"
berthoud_pass.icon = "https://lift.opensnow.com/location-logos/default_US.png"
berthoud_pass.image_url = "https://www.skyhinews.com/wp-content/uploads/2016/08/GC_GC200810355170161AR.jpg"
berthoud_pass.latitude = "39.798387"
berthoud_pass.longitude = "-105.777502"
berthoud_pass.resort_link = "http://berthoudpass.org/"
berthoud_pass.save!

breckenridge = Resort.find_or_initialize_by(id: 6)
breckenridge.base_elevation = "9,600"
breckenridge.summit_elevation = "12,998"
breckenridge.icon = "https://lift.opensnow.com/location-logos/breckenridge.png"
breckenridge.image_url = "https://static.wixstatic.com/media/e90206_1106fc4f8dec499c8585e2b2dc4c2d21~mv2.jpg/v1/fill/w_1024,h_600,al_c,q_85,usm_0.66_1.00_0.01/e90206_1106fc4f8dec499c8585e2b2dc4c2d21~mv2.webp"
breckenridge.latitude = "39.481233"
breckenridge.longitude = "-106.066103"
breckenridge.resort_link = "http://www.breckenridge.com"
breckenridge.save!

buttermilk = Resort.find_or_initialize_by(id: 7)
buttermilk.base_elevation = "8,104"
buttermilk.summit_elevation = "12,510"
buttermilk.icon = "https://lift.opensnow.com/location-logos/aspenmountain.png"
buttermilk.image_url = "https://www.skimag.com/.image/t_share/MTQzNTg0MTYyMzQ3Njg5MzYw/why-ski-beaver-creek-colorado-tout.jpg"
buttermilk.latitude = "39.209199"
buttermilk.longitude = "-106.949355"
buttermilk.resort_link = "http://www.aspensnowmass.com"
buttermilk.save!

cameron_pass = Resort.find_or_initialize_by(id: 8)
cameron_pass.base_elevation = "10,276"
cameron_pass.summit_elevation = "10,276"
cameron_pass.icon = "https://lift.opensnow.com/location-logos/default_US.png"
cameron_pass.image_url = "https://www.fs.usda.gov/Internet/FSE_MEDIA/stelprdb5446926.jpg"
cameron_pass.latitude = "40.520814"
cameron_pass.longitude = "-105.892507"
cameron_pass.save!

cooper = Resort.find_or_initialize_by(id: 9)
cooper.base_elevation = "10,500"
cooper.summit_elevation = "11,700"
cooper.icon = "https://lift.opensnow.com/location-logos/skicooper.png"
cooper.image_url = "https://www.coloradoski.com/sites/default/files/2018-07/CSCUSA%20front%20image.jpg"
cooper.latitude = "39.360798"
cooper.longitude = "-106.302807"
cooper.resort_link = "http://www.skicooper.com/"
cooper.save!

copper = Resort.find_or_initialize_by(id: 10)
copper.base_elevation = "9,712"
copper.summit_elevation = "12,313"
copper.icon = "https://lift.opensnow.com/location-logos/copper.png"
copper.image_url = "http://www.mountainyahoos.com/SkiResorts/Copper-Mountain-CO/Center_Village-DSC02169_DSC02170-2-images-1274x675.jpg"
copper.latitude = "39.499626"
copper.longitude = "-106.155680"
copper.resort_link = "http://www.coppercolorado.com"
copper.save!

crested_butte = Resort.find_or_initialize_by(id: 11)
crested_butte.base_elevation = "9,375"
crested_butte.summit_elevation = "12,162"
crested_butte.icon = "https://lift.opensnow.com/location-logos/crestedbutte.png"
crested_butte.image_url = "https://theknow.denverpost.com/wp-content/uploads/2018/12/Leeth-I-1377-1837.jpg"
crested_butte.latitude = "38.899141"
crested_butte.longitude = "-106.965532"
crested_butte.resort_link = "http://www.skicb.com"
crested_butte.save!

echo = Resort.find_or_initialize_by(id: 12)
echo.base_elevation = "10,050"
echo.summit_elevation = "10,650"
echo.icon = "https://lift.opensnow.com/location-logos/echomountain.png"
echo.image_url = "https://img6.onthesnow.com/image/la/99/99065.jpg"
echo.latitude = "39.684609"
echo.longitude = "-105.519361"
echo.resort_link = "https://echomntn.com/"
echo.save!

eldora = Resort.find_or_initialize_by(id: 13)
eldora.base_elevation = "9,200"
eldora.summit_elevation = "10,600"
eldora.icon = "https://lift.opensnow.com/location-logos/eldora.png"
eldora.image_url = "https://cms.eldora.com/sites/eldora/files/styles/medium/public/2017-08/mountain%20stats%20ver1.JPG?itok=N2n_b0lM"
eldora.latitude = "39.937261"
eldora.longitude = "-105.582625"
eldora.resort_link = "http://www.eldora.com"
eldora.save!

hesperus = Resort.find_or_initialize_by(id: 14)
hesperus.base_elevation = "8,091"
hesperus.summit_elevation = "8,888"
hesperus.icon = "https://lift.opensnow.com/location-logos/hesperus.png"
hesperus.image_url = "https://www.mcp.ski/wp-content/uploads/2018/04/Nordic-Valley-SQ-650.jpg"
hesperus.latitude = "37.299298"
hesperus.longitude = "-108.054989"
hesperus.resort_link = "https://www.ski-hesperus.com/"
hesperus.save!

irwin = Resort.find_or_initialize_by(id: 15)
irwin.base_elevation = "10,660"
irwin.summit_elevation = "14,000"
irwin.icon = "https://lift.opensnow.com/location-logos/irwin.png"
irwin.image_url = "https://elevenexperience.com/wp-content/uploads/2016/10/COadventure-9859.jpg"
irwin.latitude = "38.875598"
irwin.longitude = "-107.096272"
irwin.resort_link = "http://www.irwincolorado.com/"
irwin.save!

keystone = Resort.find_or_initialize_by(id: 16)
keystone.base_elevation = "9,280"
keystone.summit_elevation = "12,408"
keystone.icon = "https://lift.opensnow.com/location-logos/keystone.png"
keystone.image_url = "https://static.evo.com/content/travel-guides/colorado/keystone/keystone_1.jpg"
keystone.latitude = "39.605086"
keystone.longitude = "-105.951593"
keystone.resort_link = "https://www.keystoneresort.com"
keystone.save!

loveland = Resort.find_or_initialize_by(id: 17)
loveland.base_elevation = "10,800"
loveland.summit_elevation = "13,010"
loveland.icon = "https://lift.opensnow.com/location-logos/loveland.png"
loveland.image_url = "https://skiloveland.com/wp-content/uploads/2017/10/LovelandSkiAreaFrontSign.jpg"
loveland.latitude = "39.680029"
loveland.longitude = "-105.897753"
loveland.resort_link = "http://www.skiloveland.com"
loveland.save!

monarch = Resort.find_or_initialize_by(id: 18)
monarch.base_elevation = "10,790"
monarch.summit_elevation = "11,952"
monarch.icon = "https://lift.opensnow.com/location-logos/monarch.png"
monarch.image_url = "https://c8.alamy.com/comp/EK3YNW/view-from-mirkwood-hike-to-terrain-monarch-mountain-ski-snowboard-EK3YNW.jpg"
monarch.latitude = "38.512107"
monarch.longitude = "-106.332200"
monarch.resort_link = "http://www.skimonarch.com"
monarch.save!

powderhorn = Resort.find_or_initialize_by(id: 19)
powderhorn.base_elevation = "8,200"
powderhorn.summit_elevation = "9,850"
powderhorn.icon = "https://lift.opensnow.com/location-logos/powderhorn.png"
powderhorn.image_url = "https://www.coloradoski.com/sites/default/files/styles/blog_teaser_/public/2019-04/3.17.19_BeachBluebirdTerrainParkIlRifugioLowRez_5.jpg?itok=cgWZRi8w"
powderhorn.latitude = "39.069514"
powderhorn.longitude = "-108.150696"
powderhorn.resort_link = "http://www.powderhorn.com/"
powderhorn.save!

purgatory = Resort.find_or_initialize_by(id: 20)
purgatory.base_elevation = "8,793"
purgatory.summit_elevation = "10,822"
purgatory.icon = "https://lift.opensnow.com/location-logos/purgatory.png"
purgatory.image_url = "https://www.colorado.com/sites/default/files/styles/640x480/public/zzdata-5565_720x480.jpg?itok=BEl9uouu"
purgatory.latitude = "37.630205"
purgatory.longitude = "-107.814044"
purgatory.resort_link = "http://www.PurgatoryResort.com"
purgatory.save!

rocky_mountain= Resort.find_or_initialize_by(id: 21)
rocky_mountain.base_elevation = "7,860"
rocky_mountain.summit_elevation = "14,259"
rocky_mountain.icon = "https://lift.opensnow.com/location-logos/default_US.png"
rocky_mountain.image_url = "https://files.opensnow.com/News/2019/01-January/Estes-Park/EstesPark-4-v2.png"
rocky_mountain.latitude = "40.341364"
rocky_mountain.longitude = "-105.683616"
rocky_mountain.resort_link = "http://climbinglife.com/?Itemid=112&option=com_content&view=category&id=27"
rocky_mountain.save!

silverton = Resort.find_or_initialize_by(id: 22)
silverton.base_elevation = "10,400"
silverton.summit_elevation = "13,487"
silverton.icon = "https://lift.opensnow.com/location-logos/silverton.png"
silverton.image_url = "https://snowbrains.com/wp-content/uploads/2019/01/Silverton-Mountain-Main-Photo-min.jpg"
silverton.latitude = "37.884616"
silverton.longitude = "-107.665994"
silverton.resort_link = "http://www.silvertonmountain.com/"
silverton.save!

granby = Resort.find_or_initialize_by(id: 23)
granby.base_elevation = "8,202"
granby.summit_elevation = "9,202"
granby.icon = "https://lift.opensnow.com/location-logos/skigranby.png"
granby.image_url = "https://images2.westword.com/imager/ski-granby-ranch/u/745x420/5165955/7588599.0.jpg"
granby.latitude = "40.044329"
granby.longitude = "-105.906155"
granby.resort_link = "http://www.granbyranch.com/"
granby.save!

snowmass = Resort.find_or_initialize_by(id: 24)
snowmass.base_elevation = "8,104"
snowmass.summit_elevation = "12,510"
snowmass.icon = "https://lift.opensnow.com/location-logos/snowmass.png"
snowmass.image_url = "https://res.cloudinary.com/sagacity/image/upload/c_crop,h_1365,w_2048,x_0,y_0/c_limit,dpr_auto,f_auto,fl_lossy,q_80,w_1080/SnowmassSwanson_fijfs1.jpg"
snowmass.latitude = "39.208796"
snowmass.longitude = "-106.949670"
snowmass.resort_link = "http://www.aspensnowmass.com/"
snowmass.save!

steamboat = Resort.find_or_initialize_by(id: 25)
steamboat.base_elevation = "6,900"
steamboat.summit_elevation = "10,568"
steamboat.icon = "https://lift.opensnow.com/location-logos/steamboat.png"
steamboat.image_url = "https://img6.onthesnow.com/image/xl/73/73931.jpg"
steamboat.latitude = "40.457158"
steamboat.longitude = "-106.804372"
steamboat.resort_link = "http://steamboat.com"
steamboat.save!

sunlight = Resort.find_or_initialize_by(id: 26)
sunlight.base_elevation = "7,885"
sunlight.summit_elevation = "9,895"
sunlight.icon = "https://lift.opensnow.com/location-logos/sunlight.png"
sunlight.image_url = "https://www.firsttracksonline.com/wp-content/uploads/2015/11/sunlight-672x372.jpg"
sunlight.latitude = "39.399765"
sunlight.longitude = "-107.338604"
sunlight.resort_link = "http://www.sunlightmtn.com/"
sunlight.save!

telluride = Resort.find_or_initialize_by(id: 27)
telluride.base_elevation = "8,725"
telluride.summit_elevation = "13,150"
telluride.icon = "https://lift.opensnow.com/location-logos/telluride.png"
telluride.image_url = "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Flarryolmsted%2Ffiles%2F2017%2F01%2FVisitTelluride.TownWinter3.PhotoCredit-Telluride-Tourism-Board-Ryan-Bonneau.jpg"
telluride.latitude = "37.912462"
telluride.longitude = "-107.838621"
telluride.resort_link = "http://www.tellurideskiresort.com"
telluride.save!

vail = Resort.find_or_initialize_by(id: 28)
vail.base_elevation = "8,120"
vail.summit_elevation = "11,570"
vail.icon = "https://lift.opensnow.com/location-logos/vail.png"
vail.image_url = "https://usatunofficial.files.wordpress.com/2015/10/vail.jpg?w=1000&h=600&crop=1"
vail.latitude = "39.606037"
vail.longitude = "-106.355004"
vail.resort_link = "http://www.vail.com"
vail.save!

winter_park = Resort.find_or_initialize_by(id: 29)
winter_park.base_elevation = "9,000"
winter_park.summit_elevation = "12,060"
winter_park.icon = "https://lift.opensnow.com/location-logos/winterpark.png"
winter_park.image_url = "https://www.winterparkresort.com/-/media/winter-park/_mobile-images/_750x422/getting-here/fly_m.ashx?h=422&w=750&hash=095D8F8E044CE0051707598EDEC782E0"
winter_park.latitude = "39.886848"
winter_park.longitude = "-105.762838"
winter_park.resort_link = "http://www.winterparkresort.com"
winter_park.save!

wolf_creek = Resort.find_or_initialize_by(id: 30)
wolf_creek.base_elevation = "10,300"
wolf_creek.summit_elevation = "11,904"
wolf_creek.icon = "https://lift.opensnow.com/location-logos/wolfcreekcolorado.png"
wolf_creek.image_url = "https://i.pinimg.com/originals/8f/79/39/8f793989c7d38a2eb53615c7c45486b4.jpg"
wolf_creek.latitude = "37.474759"
wolf_creek.longitude = "-106.793583"
wolf_creek.resort_link = "http://www.wolfcreekski.com/"
wolf_creek.save!

alpine_meadows = Resort.find_or_initialize_by(id: 31)
alpine_meadows.base_elevation = "6,200"
alpine_meadows.summit_elevation = "9,050"
alpine_meadows.icon = "https://lift.opensnow.com/location-logos/alpinemeadows.png"
alpine_meadows.image_url = "https://images.ctfassets.net/bkxhksvqddg5/2Mm6mq3UfueYMku6OWa8oO/ff71445dabe561ac642b5d2a8f5fa2e3/SVAM-Tram-1280x960.jpg?w=1280&h=960&fit=scale"
alpine_meadows.latitude = "39.164674"
alpine_meadows.longitude = "-120.238570"
alpine_meadows.resort_link = "https://squawalpine.com/"
alpine_meadows.save!

alta_sierra = Resort.find_or_initialize_by(id: 32)
alta_sierra.base_elevation = "2,310"
alta_sierra.summit_elevation = "5,718"
alta_sierra.icon = "https://lift.opensnow.com/location-logos/altasierra.png"
alta_sierra.image_url = "http://www.skichinapeak.com/Content/images/snow.jpg"
alta_sierra.latitude = "35.711181"
alta_sierra.longitude = "-118.560079"
alta_sierra.resort_link = "http://www.altasierra.com/"
alta_sierra.save!

bear = Resort.find_or_initialize_by(id: 33)
bear.base_elevation = "7,140"
bear.summit_elevation = "8,805"
bear.icon = "https://lift.opensnow.com/location-logos/bearmountain.png"
bear.image_url = "https://www.tripsavvy.com/thmb/RG4KaXftRY2EjKln2KD22qy4sVw=/960x0/filters:no_upscale():max_bytes(150000):strip_icc()/SnowSummit_LiftLakeFreshSnow2-56a3e74e5f9b58b7d0d45fdd-59c29754c4124400108550de.jpg"
bear.latitude = "34.227748"
bear.longitude = "-116.860697"
bear.resort_link = "http://www.bigbearmountainresort.com"
bear.save!

bear_valley = Resort.find_or_initialize_by(id: 34)
bear_valley.base_elevation = "6,600"
bear_valley.summit_elevation = "8,500"
bear_valley.icon = "https://lift.opensnow.com/location-logos/bearvalley.png"
bear_valley.image_url = "https://img1.onthesnow.com/image/xl/18/18.jpg"
bear_valley.latitude = "38.492542"
bear_valley.longitude = "-120.044209"
bear_valley.resort_link = "http://www.bearvalley.com/"
bear_valley.save!

boreal = Resort.find_or_initialize_by(id: 35)
boreal.base_elevation = "7,200"
boreal.summit_elevation = "7,700"
boreal.icon = "https://lift.opensnow.com/location-logos/boreal.png"
boreal.image_url = "https://thetahoeweekly.com/files/wp-content/uploads/2018/09/2016_Boreal_MountainOverview_Evening_Lights_HR_JakePollock_ReEdit.jpg"
boreal.latitude = "39.336470"
boreal.longitude = "-120.350017"
boreal.resort_link = "https://www.rideboreal.com"
boreal.save!

china_peak = Resort.find_or_initialize_by(id: 36)
china_peak.base_elevation = "7,030"
china_peak.summit_elevation = "8,700"
china_peak.icon = "https://lift.opensnow.com/location-logos/chinapeak.png"
china_peak.image_url = "https://www.fresnobee.com/latest-news/tlrvp2/picture223318405/alternates/FREE_960/ChinaPeak07.JPG"
china_peak.latitude = "37.236534"
china_peak.longitude = "-119.157253"
china_peak.resort_link = "http://www.skichinapeak.com/"
china_peak.save!

dodge_ridge = Resort.find_or_initialize_by(id: 37)
dodge_ridge.base_elevation = "6,600"
dodge_ridge.summit_elevation = "8,200"
dodge_ridge.icon = "https://lift.opensnow.com/location-logos/dodgeridge.png"
dodge_ridge.image_url = "https://img6.onthesnow.com/image/la/52/aspen_snowmass_1_524633.jpg"
dodge_ridge.latitude = "38.189936"
dodge_ridge.longitude = "-119.955864"
dodge_ridge.resort_link = "https://www.dodgeridge.com/"
dodge_ridge.save!
 
donner = Resort.find_or_initialize_by(id: 38)
donner.base_elevation = "7,031"
donner.summit_elevation = "8,012"
donner.icon = "https://lift.opensnow.com/location-logos/donnerskiranch.png"
donner.image_url = "https://static1.squarespace.com/static/581b7797cd0f68b05009ce5e/t/58211b1437c5817cf1d1a52b/1478564628902/DSR.jpg"
donner.latitude = "39.317607"
donner.longitude = "-120.330351"
donner.resort_link = "https://www.donnerskiranch.com/"
donner.save!

heavenly = Resort.find_or_initialize_by(id: 39)
heavenly.base_elevation = "7,170"
heavenly.summit_elevation = "10,067"
heavenly.icon = "https://lift.opensnow.com/location-logos/heavenly.png"
heavenly.image_url = "https://img4.onthesnow.com/image/xl/40/4023.jpg"
heavenly.latitude = "38.936206 "
heavenly.longitude = "-119.938912"
heavenly.resort_link = "http://www.skiheavenly.com/"
heavenly.save!

homewood = Resort.find_or_initialize_by(id: 40)
homewood.base_elevation = "6,230"
homewood.summit_elevation = "7,880"
homewood.icon = "https://lift.opensnow.com/location-logos/homewood.png"
homewood.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/08/13/29/02/homewood-mountain-resort.jpg"
homewood.latitude = "39.076368 "
homewood.longitude = "-120.179939"
homewood.resort_link = "http://www.skihomewood.com/"
homewood.save!

june = Resort.find_or_initialize_by(id: 41)
june.base_elevation = "7,545"
june.summit_elevation = "10,090"
june.icon = "https://lift.opensnow.com/location-logos/junemountain.png"
june.image_url = "https://www.junelakeaccommodations.com/custimages/June-Mountain-Ski-Area/june-mountain-ski-area-landscape.jpg"
june.latitude = "37.742874"
june.longitude = "-119.070737"
june.resort_link = "http://www.junemountain.com/"
june.save!

kirkwood = Resort.find_or_initialize_by(id: 42)
kirkwood.base_elevation = "7,800"
kirkwood.summit_elevation = "9,800"
kirkwood.icon = "https://lift.opensnow.com/location-logos/kirkwood.png"
kirkwood.image_url = "https://www.ridgetahoeresort.com/wp-content/uploads/2013/11/kirkwood.jpg"
kirkwood.latitude = "38.674615"
kirkwood.longitude = "-120.064396"
kirkwood.resort_link = "http://www.kirkwood.com/"
kirkwood.save!
 
mammoth = Resort.find_or_initialize_by(id: 43)
mammoth.base_elevation = "7,953"
mammoth.summit_elevation = "11,053"
mammoth.icon = "https://lift.opensnow.com/location-logos/mammothmountain.png"
mammoth.image_url = "https://www.pressdemocrat.com/csp/mediapool/sites/dt.common.streams.StreamServer.cls?STREAMOID=NxyPnu1Pbu53b9Ah0KAME8$daE2N3K4ZzOUsqbU5sYtq2aZ4wd82nKCRY_pfIe1UWCsjLu883Ygn4B49Lvm9bPe2QeMKQdVeZmXF$9l$4uCZ8QDXhaHEp3rvzXRJFdy0KqPHLoMevcTLo3h8xh70Y6N_U_CryOsw6FTOdKL_jpQ-&CONTENTTYPE=image/jpeg"
mammoth.latitude = "37.641075"
mammoth.longitude = "-119.028455"
mammoth.resort_link = "http://www.mammothmountain.com/"
mammoth.save!
 
baldy = Resort.find_or_initialize_by(id: 44)
baldy.base_elevation = "5,666"
baldy.summit_elevation = "6,965"
baldy.icon = "https://lift.opensnow.com/location-logos/mtbaldy.png"
baldy.image_url = "https://winter.mtbaldyresort.com/wp-content/uploads/2018/10/skiing-snowboarding.jpg"
baldy.latitude = "34.236786"
baldy.longitude = "-117.657923"
baldy.resort_link = "http://www.mtbaldyskilifts.com/"
baldy.save!
 
mt_high = Resort.find_or_initialize_by(id: 45)
mt_high.base_elevation = "6,600"
mt_high.summit_elevation = "8,200"
mt_high.icon = "https://lift.opensnow.com/location-logos/mountainhigh.png"
mt_high.image_url = "https://img5.onthesnow.com/image/gg/33/339496.jpg"
mt_high.latitude = "34.375250"
mt_high.longitude = "-117.692211"
mt_high.resort_link = "http://www.mthigh.com/"
mt_high.save!
 
shasta = Resort.find_or_initialize_by(id: 46)
shasta.base_elevation = "5,500"
shasta.summit_elevation = "6,890"
shasta.icon = "https://lift.opensnow.com/location-logos/mtshastaskipark.png"
shasta.image_url = "http://media.heartlandtv.com/images/Mount+Shasta.JPG"
shasta.latitude = "41.409164"
shasta.longitude = "-122.194925"
shasta.resort_link = "http://skipark.com/"
shasta.save!
 
northstar = Resort.find_or_initialize_by(id: 47)
northstar.base_elevation = "6,330"
northstar.summit_elevation = "8,610"
northstar.icon = "https://lift.opensnow.com/location-logos/northstar.png"
northstar.image_url = "https://moonshineink.com/wp-content/uploads/2018/12/northstar_press_2.jpg"
northstar.latitude = "39.273812"
northstar.longitude = "-120.121887"
northstar.resort_link = "http://www.northstarattahoe.com/"
northstar.save!

sierra_tahoe = Resort.find_or_initialize_by(id: 48)
sierra_tahoe.base_elevation = "6,640"
sierra_tahoe.summit_elevation = "8,852"
sierra_tahoe.icon = "https://lift.opensnow.com/location-logos/sierraattahoe.png"
sierra_tahoe.image_url = "https://cf.ltkcdn.net/ski/images/std/139006-388x309-sierra-at-tahoe.jpg"
sierra_tahoe.latitude = "38.800736 "
sierra_tahoe.longitude = "-120.080619"
sierra_tahoe.resort_link = "http://www.sierraattahoe.com/"
sierra_tahoe.save!

snow_summit = Resort.find_or_initialize_by(id: 49)
snow_summit.base_elevation = "7,000"
snow_summit.summit_elevation = "8,200"
snow_summit.icon = "https://lift.opensnow.com/location-logos/snowsummit.png"
snow_summit.image_url = "https://www.tripsavvy.com/thmb/RG4KaXftRY2EjKln2KD22qy4sVw=/960x0/filters:no_upscale():max_bytes(150000):strip_icc()/SnowSummit_LiftLakeFreshSnow2-56a3e74e5f9b58b7d0d45fdd-59c29754c4124400108550de.jpg"
snow_summit.latitude = "34.220647"
snow_summit.longitude = "-116.892370"
snow_summit.resort_link = "https://www.bigbearmountainresort.com"
snow_summit.save!

snow_valley = Resort.find_or_initialize_by(id: 50)
snow_valley.base_elevation = "6,800"
snow_valley.summit_elevation = "7,841"
snow_valley.icon = "https://lift.opensnow.com/location-logos/snowvalley.png"
snow_valley.image_url = "https://powdercam.com/Media/PowderCam/Photos/Americas/North%20America/Western%20US/California/Snow%20Valley%20Ski%20Resort/snowvalley_600.jpg"
snow_valley.latitude = "34.224847"
snow_valley.longitude = "-117.036091"
snow_valley.resort_link = "http://www.snow-valley.com/"
snow_valley.save!

soda = Resort.find_or_initialize_by(id: 51)
soda.base_elevation = "6,700"
soda.summit_elevation = "7,352"
soda.icon = "https://lift.opensnow.com/location-logos/sodasprings.png"
soda.image_url = "https://skicalifornia.org/wp-content/uploads/2017/10/SODA-SPRINGS-HEADER.jpg"
soda.latitude = "39.321348"
soda.longitude = "-120.380175"
soda.resort_link = "http://www.skisodasprings.com/"
soda.save!

squaw = Resort.find_or_initialize_by(id: 52)
squaw.base_elevation = "6,200"
squaw.summit_elevation = "9,050"
squaw.icon = "https://lift.opensnow.com/location-logos/squawvalley.png"
squaw.image_url = "https://squawalpine.com/sites/default/files/styles/hero__1920x1080_/public/header/homeslide_scenic-winter.jpg?itok=PDU6dXVV"
squaw.latitude = "39.197249"
squaw.longitude = "-120.235350"
squaw.resort_link = "http://www.squaw.com/"
squaw.save!

sugar_bowl = Resort.find_or_initialize_by(id: 53)
sugar_bowl.base_elevation = "6,883"
sugar_bowl.summit_elevation = "8,383"
sugar_bowl.icon = "https://lift.opensnow.com/location-logos/sugarbowl.png"
sugar_bowl.image_url = "https://external-preview.redd.it/-t6T66urWfjIRgTaYGZ53n0K1c-h-7ipCYmrYn0wZi8.jpg?auto=webp&s=320609de0af17abeaa3031df038a421a3b9c50c9"
sugar_bowl.latitude = "39.300493"
sugar_bowl.longitude = "-120.333649"
sugar_bowl.resort_link = "http://www.sugarbowl.com/"
sugar_bowl.save!

tahoe_donner = Resort.find_or_initialize_by(id: 54)
tahoe_donner.base_elevation = "6,750"
tahoe_donner.summit_elevation = "7,350"
tahoe_donner.icon = "https://lift.opensnow.com/location-logos/tahoedonner.png"
tahoe_donner.image_url = "https://www.tahoedonner.com/wp-content/uploads/sb-instagram-feed-images/45806879_263984277622892_8189905825768357662_nfull.jpg"
tahoe_donner.latitude = "39.354028"
tahoe_donner.longitude = "-120.259127"
tahoe_donner.resort_link = "http://www.tahoedonner.com/downhill/mountain.html"
tahoe_donner.save!
 
yosemite = Resort.find_or_initialize_by(id: 55)
yosemite.base_elevation = "7,200"
yosemite.summit_elevation = "7,800"
yosemite.icon = "https://lift.opensnow.com/location-logos/default_US.png"
yosemite.image_url = "https://img4.onthesnow.com/image/la/37/mammoth_powder_378501.jpg"
yosemite.latitude = "37.662976"
yosemite.longitude = "-119.663878"
yosemite.resort_link = "http://www.travelyosemite.com/winter/yosemite-ski-snowboard-area-webcam/"
yosemite.save!

targhee = Resort.find_or_initialize_by(id: 56)
targhee.base_elevation = "7,851"
targhee.summit_elevation = "9,920"
targhee.icon = "https://lift.opensnow.com/location-logos/grandtarghee.png"
targhee.image_url = "https://www.skimag.com/.image/t_share/MTQzNjA2ODIxNzg4Mzk1MzY5/grand-targhee-10-best.jpg"
targhee.latitude = "43.786888"
targhee.longitude = "-110.959039"
targhee.resort_link = "https://www.grandtarghee.com/"
targhee.save!

hogadon = Resort.find_or_initialize_by(id: 57)
hogadon.base_elevation = "7,400"
hogadon.summit_elevation = "8,000"
hogadon.icon = "https://lift.opensnow.com/location-logos/hogadon.png"
hogadon.image_url = "http://hogadon.net/UserFiles/Servers/Server_62983/Templates/HogadonSkiArea.jpg"
hogadon.latitude = "42.745117"
hogadon.longitude = "-106.339639"
hogadon.resort_link = "http://www.casperwy.gov/Play/OutdoorSports/Skiing/tabid/405/Default.aspx"
hogadon.save!
 
jackson = Resort.find_or_initialize_by(id: 58)
jackson.base_elevation = "6,311"
jackson.summit_elevation = "10,450"
jackson.icon = "https://lift.opensnow.com/location-logos/jacksonhole.png"
jackson.image_url = "https://www.powderhounds.com/site/DefaultSite/filesystem/images/USA/JacksonHole/Overview/01.jpg"
jackson.latitude = "43.588190"
jackson.longitude = "-110.828208"
jackson.resort_link = "http://www.jacksonhole.com/"
jackson.save!
 
meadowlark = Resort.find_or_initialize_by(id: 59)
meadowlark.base_elevation = "8,500"
meadowlark.summit_elevation = "9,500"
meadowlark.icon = "https://lift.opensnow.com/location-logos/meadowlark.png"
meadowlark.image_url = "https://moneyinc.com/wp-content/uploads/2017/01/Sleeping-Giant-750x422.jpg"
meadowlark.latitude = "44.173956"
meadowlark.longitude = "-107.214561"
meadowlark.resort_link = "http://www.lodgesofthebighorns.com/meadowlarkskilodge.html"
meadowlark.save!
 
sleeping_giant = Resort.find_or_initialize_by(id: 60)
sleeping_giant.base_elevation = "6,619"
sleeping_giant.summit_elevation = "7,428"
sleeping_giant.icon = "https://lift.opensnow.com/location-logos/sleepinggiant.png"
sleeping_giant.image_url = "https://partners.travelwyoming.com/uploads/photos/imported-27993/27993-3406-12177.jpg"
sleeping_giant.latitude = "44.495061"
sleeping_giant.longitude = "-109.943640"
sleeping_giant.resort_link = "http://www.skisg.com/"
sleeping_giant.save!
 
snow_king = Resort.find_or_initialize_by(id: 61)
snow_king.base_elevation = "6,237"
snow_king.summit_elevation = "7,808"
snow_king.icon = "https://lift.opensnow.com/location-logos/snowking.png"
snow_king.image_url = "https://skimap.org/data/156/2200/1452391042jpg_render.jpg"
snow_king.latitude = "43.473246"
snow_king.longitude = "-110.755986"
snow_king.resort_link = "http://www.snowking.com/Activities_WinterActivities_SkiArea.aspx"
snow_king.save!
 
snowy_range = Resort.find_or_initialize_by(id: 62)
snowy_range.base_elevation = "8,798"
snowy_range.summit_elevation = "9,663"
snowy_range.icon = "https://lift.opensnow.com/location-logos/snowyrange.png"
snowy_range.image_url = "http://www.sangres.com/dimages/wyoming/skiareas/snowyrange01.jpg"
snowy_range.latitude = "41.347554"
snowy_range.longitude = "-106.326129"
snowy_range.resort_link = "http://www.snowyrangeski.com/"
snowy_range.save!
 
teton = Resort.find_or_initialize_by(id: 63)
teton.base_elevation = "6,190"
teton.summit_elevation = "7,200"
teton.icon = "https://lift.opensnow.com/location-logos/default_US.png"
teton.image_url = "https://bloximages.chicago2.vip.townnews.com/choteauacantha.com/content/tncms/assets/v3/editorial/d/a9/da996276-d4ac-11e9-b449-6bf62ac7a020/5d791994d80bd.image.jpg?resize=1200%2C800"
teton.latitude = "43.497528"
teton.longitude = "-110.954949"
teton.resort_link = ""
teton.save!

white_pine = Resort.find_or_initialize_by(id: 64)
white_pine.base_elevation = "8,400"
white_pine.summit_elevation = "9,500"
white_pine.icon = "https://lift.opensnow.com/location-logos/whitepine.png"
white_pine.image_url = "http://www.utahoutside.com/wp-content/uploads/2010/02/whitepine5.jpg"
white_pine.latitude = "42.977528"
white_pine.longitude = "-109.757984"
white_pine.resort_link = "http://www.whitepineski.com/"
white_pine.save!

bald = Resort.find_or_initialize_by(id: 65)
bald.base_elevation = "5,750"
bald.summit_elevation = "9,150"
bald.icon = "https://lift.opensnow.com/location-logos/baldmountain.png"
bald.image_url = "https://upload.wikimedia.org/wikipedia/commons/d/da/Baldmountainid.jpg"
bald.latitude = "46.574683"
bald.longitude = "-115.870735"
bald.resort_link = "http://skibaldmountain.com/"
bald.save!
 
bogus = Resort.find_or_initialize_by(id: 66)
bogus.base_elevation = "5,800"
bogus.summit_elevation = "7,582"
bogus.icon = "https://lift.opensnow.com/location-logos/bogusbasin.png"
bogus.image_url = "https://visitidaho.org/content/uploads/2015/12/Boise-Skiing.jpg"
bogus.latitude = "43.764056"
bogus.longitude = "-116.102431"
bogus.resort_link = "http://www.bogusbasin.org/"
bogus.save!

brundage = Resort.find_or_initialize_by(id: 67)
brundage.base_elevation = "5,840"
brundage.summit_elevation = "7,640"
brundage.icon = "https://lift.opensnow.com/location-logos/brundage.png"
brundage.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/02/31/b5/74/brundage-mountain-summit.jpg"
brundage.latitude = "45.005354"
brundage.longitude = "-116.154401"
brundage.resort_link = "http://www.brundage.com/"
brundage.save!
 
cottonwood = Resort.find_or_initialize_by(id: 68)
cottonwood.base_elevation = "2,100"
cottonwood.summit_elevation = "5,730"
cottonwood.icon = "https://lift.opensnow.com/location-logos/cottonwoodbutte.png"
cottonwood.image_url = "http://visitsunvalley.com/wordpress/wp-content/uploads/157153-Sun-Valley-Ski-Resort.jpg"
cottonwood.latitude = "46.075615"
cottonwood.longitude = "-116.452635"
cottonwood.resort_link = "http://www.cottonwoodbutte.org/"
cottonwood.save!

kelly = Resort.find_or_initialize_by(id: 69)
kelly.base_elevation = "5,600"
kelly.summit_elevation = "6,600"
kelly.icon = "https://lift.opensnow.com/location-logos/kellycanyon.png"
kelly.image_url = "https://www.tripsavvy.com/thmb/zDI0hoZQHFMlxsf68gWXNaxkXX8=/2125x1195/smart/filters:no_upscale()/GettyImages-150644155-5824d9c95f9b58d5b1b7dadc.jpg"
kelly.latitude = "43.644486"
kelly.longitude = "-111.630705"
kelly.resort_link = "http://www.skikelly.com/"
kelly.save!
 
little_hill = Resort.find_or_initialize_by(id: 70)
little_hill.base_elevation = "5,195"
little_hill.summit_elevation = "5,600"
little_hill.icon = "https://lift.opensnow.com/location-logos/littleskihill.png"
little_hill.image_url = "https://media.cntraveler.com/photos/5894ab2a6ec1a4c97510c2f7/master/pass/ski-vermont-stowe-cr-courtesy.jpg"
little_hill.latitude = "44.930116"
little_hill.longitude = "-116.162414"
little_hill.resort_link = "http://www.littleskihill.org/"
little_hill.save!
 
lookout = Resort.find_or_initialize_by(id: 71)
lookout.base_elevation = "4,500"
lookout.summit_elevation = "5,650"
lookout.icon = "https://lift.opensnow.com/location-logos/lookoutpass.png"
lookout.image_url = "https://img6.onthesnow.com/image/gg/52/1_525185.jpg"
lookout.latitude = "47.455340"
lookout.longitude = "-115.697038"
lookout.resort_link = "https://skilookout.com/"
lookout.save!
 
magic = Resort.find_or_initialize_by(id: 72)
magic.base_elevation = "6,500"
magic.summit_elevation = "7,200"
magic.icon = "https://lift.opensnow.com/location-logos/magicmountain.png"
magic.image_url = "https://www.outsideonline.com/sites/default/files/styles/full-page/public/migrated-images_parent/migrated-images_66/red-mountain-best-powder-skiing_h1.jpg?itok=PIILAHOw"
magic.latitude = "42.189305"
magic.longitude = "-114.285501"
magic.resort_link = "http://www.magicmountainresort.com/"
magic.save!

pebble = Resort.find_or_initialize_by(id: 73)
pebble.base_elevation = "6,360"
pebble.summit_elevation = "8,560"
pebble.icon = "https://lift.opensnow.com/location-logos/pebblecreek.png"
pebble.image_url = "https://api.trekaroo.com//system/photos/232965/original/351982372_684f81e982_z.jpg?1493804523"
pebble.latitude = "42.778378"
pebble.longitude = "-112.159311"
pebble.resort_link = "http://www.pebblecreekskiarea.com/"
pebble.save!
 
pomrelle = Resort.find_or_initialize_by(id: 74)
pomrelle.base_elevation = "8,000"
pomrelle.summit_elevation = "9,000"
pomrelle.icon = "https://lift.opensnow.com/location-logos/ponerelle.png"
pomrelle.image_url = "https://img3.onthesnow.com/image/gg/89/89294.jpg"
pomrelle.latitude = "42.317979"
pomrelle.longitude = "-113.607784"
pomrelle.resort_link = "http://www.pomerelle.com/"
pomrelle.save!
 
schweitzer = Resort.find_or_initialize_by(id: 75)
schweitzer.base_elevation = "4,000"
schweitzer.summit_elevation = "6,400"
schweitzer.icon = "https://lift.opensnow.com/location-logos/schweitzer.png"
schweitzer.image_url = "https://i.pinimg.com/originals/3d/be/be/3dbebe8efe44c87e6128cefb2595fc89.jpg"
schweitzer.latitude = "48.368104"
schweitzer.longitude = "-116.623034"
schweitzer.resort_link = "http://www.schweitzer.com/"
schweitzer.save!
 
silver_mountain = Resort.find_or_initialize_by(id: 76)
silver_mountain.base_elevation = "4,100"
silver_mountain.summit_elevation = "6,300"
silver_mountain.icon = "https://lift.opensnow.com/location-logos/silvermountain.png"
silver_mountain.image_url = "https://media2.fdncms.com/inlander/imager/u/original/9745882/skiing-silver-mountain-resort-kellogg_25533374003_o-700x467.jpg"
silver_mountain.latitude = "47.540886"
silver_mountain.longitude = "-116.132715"
silver_mountain.resort_link = "http://www.silvermt.com/"
silver_mountain.save!
 
snowhaven = Resort.find_or_initialize_by(id: 77)
snowhaven.base_elevation = "5,200"
snowhaven.summit_elevation = "5,600"
snowhaven.icon = "https://lift.opensnow.com/location-logos/snowhaven.png"
snowhaven.image_url = "http://whitebookski.com/wp-content/uploads/2017/04/snowhaven-ski-and-tube-hill-grangeville-id-1024x586.jpg"
snowhaven.latitude = "45.867488"
snowhaven.longitude = "-116.089300"
snowhaven.resort_link = "http://www.grangeville.us/snowhaven-main-page.html"
snowhaven.save!
 
soldier = Resort.find_or_initialize_by(id: 78)
soldier.base_elevation = "5,800"
soldier.summit_elevation = "7,200"
soldier.icon = "https://lift.opensnow.com/location-logos/soldiermountain.png"
soldier.image_url = "https://bloximages.chicago2.vip.townnews.com/magicvalley.com/content/tncms/assets/v3/editorial/a/94/a94c82fe-0915-506a-81b8-34eb026b74bd/5be9b3ec96ee1.image.jpg?resize=1200%2C900"
soldier.latitude = "43.485496"
soldier.longitude = "-114.829401"
soldier.resort_link = "http://www.soldiermountain.com/"
soldier.save!

sun_valley = Resort.find_or_initialize_by(id: 79)
sun_valley.base_elevation = "5,750"
sun_valley.summit_elevation = "9,150"
sun_valley.icon = "https://lift.opensnow.com/location-logos/sunvalley.png"
sun_valley.image_url = "https://s22867.pcdn.co/wp-content/uploads/2018/11/VSV8.jpg"
sun_valley.latitude = "43.673869"
sun_valley.longitude = "-114.371446"
sun_valley.resort_link = "http://www.sunvalley.com/"
sun_valley.save!

tamarack = Resort.find_or_initialize_by(id: 80)
tamarack.base_elevation = "4,900"
tamarack.summit_elevation = "7,700"
tamarack.icon = "https://lift.opensnow.com/location-logos/tamarack.png"
tamarack.image_url = "https://img1.onthesnow.com/image/gg/23/233034.jpg"
tamarack.latitude = "44.669729"
tamarack.longitude = "-116.124050"
tamarack.resort_link = "http://www.tamarackidaho.com/winter_adventure/index.php"
tamarack.save!

bear_paw = Resort.find_or_initialize_by(id: 81)
bear_paw.base_elevation = "4,500"
bear_paw.summit_elevation = "5,280"
bear_paw.icon = "https://lift.opensnow.com/location-logos/bearpawskibowl.png"
bear_paw.image_url = "http://www.beavercreekresortproperties.com/media/1129/bp_lg_bc_bearpaw_exteriorwinter6.jpg"
bear_paw.latitude = "48.164992"
bear_paw.longitude = "-109.670145"
bear_paw.resort_link = "http://skibearpaw.com/"
bear_paw.save!
 
bigsky = Resort.find_or_initialize_by(id: 82)
bigsky.base_elevation = "7,500"
bigsky.summit_elevation = "11,166"
bigsky.icon = "https://lift.opensnow.com/location-logos/bigsky.png"
bigsky.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/05/97/42/41/big-sky-resort.jpg"
bigsky.latitude = "45.255958"
bigsky.longitude = "-111.298395"
bigsky.resort_link = "http://www.bigskyresort.com/"
bigsky.save!
 
blacktail = Resort.find_or_initialize_by(id: 83)
blacktail.base_elevation = "5,236"
blacktail.summit_elevation = "6,676"
blacktail.icon = "https://lift.opensnow.com/location-logos/blacktailmountain.png"
blacktail.image_url = "https://www.blacktailmountain.com/wp-content/uploads/2018/12/12-25-flake.jpg"
blacktail.latitude = "48.012904"
blacktail.longitude = "-114.238071"
blacktail.resort_link = "http://www.blacktailmountain.com/"
blacktail.save!
 
bridger = Resort.find_or_initialize_by(id: 84)
bridger.base_elevation = "6,100"
bridger.summit_elevation = "8,700"
bridger.icon = "https://lift.opensnow.com/location-logos/bridgerbowl.png"
bridger.image_url = "https://i2.wp.com/www.powder.com/wp-content/uploads/2014/11/BridgerBowl.jpg?w=1600"
bridger.latitude = "45.817192"
bridger.longitude = "-110.896726"
bridger.resort_link = "http://bridgerbowl.com/"
bridger.save!
 
discovery = Resort.find_or_initialize_by(id: 85)
discovery.base_elevation = "5,770"
discovery.summit_elevation = "8,150"
discovery.icon = "https://lift.opensnow.com/location-logos/discoveryski.png"
discovery.image_url = "https://www.bigskyfishing.com/Montana-Info/ski-areas/new-discovery/d-16-m.jpg"
discovery.latitude = "46.249571"
discovery.longitude = "-113.238494"
discovery.resort_link = "http://skidiscovery.com/"
discovery.save!
 
great_divide = Resort.find_or_initialize_by(id: 86)
great_divide.base_elevation = "5,750"
great_divide.summit_elevation = "7,330"
great_divide.icon = "https://lift.opensnow.com/location-logos/greatdivide.png"
great_divide.image_url = "https://usatunofficial.files.wordpress.com/2018/10/27788257_10156072343304509_663957545217493852_o.jpg?w=1000&h=565&crop=1"
great_divide.latitude = "46.753007"
great_divide.longitude = "-112.313435"
great_divide.resort_link = "http://www.skigd.com/"
great_divide.save!
 
lost_trail = Resort.find_or_initialize_by(id: 87)
lost_trail.base_elevation = "6,400"
lost_trail.summit_elevation = "8,200"
lost_trail.icon = "https://lift.opensnow.com/location-logos/losttrailpowdermountain.png"
lost_trail.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/09/fc/f6/6c/lost-trail-powder-mountain.jpg"
lost_trail.latitude = "45.693443"
lost_trail.longitude = "-113.950136"
lost_trail.resort_link = "http://www.losttrail.com/"
lost_trail.save!
 
maverick = Resort.find_or_initialize_by(id: 88)
maverick.base_elevation = "6,500"
maverick.summit_elevation = "8,520"
maverick.icon = "https://lift.opensnow.com/location-logos/maverickmountain.png"
maverick.image_url = "https://bloximages.chicago2.vip.townnews.com/mtstandard.com/content/tncms/assets/v3/editorial/6/69/66915845-87ca-5f5e-96c8-ce5fb4654e7c/568dda5c80cff.image.jpg?resize=1200%2C800"
maverick.latitude = "45.434622"
maverick.longitude = "-113.130260"
maverick.resort_link = "http://skimaverick.com/"
maverick.save!

montana_snowbowl = Resort.find_or_initialize_by(id: 89)
montana_snowbowl.base_elevation = "5,000"
montana_snowbowl.summit_elevation = "7,600"
montana_snowbowl.icon = "https://lift.opensnow.com/location-logos/montanasnowbowl.png"
montana_snowbowl.image_url = "https://live.staticflickr.com/3437/3262458052_6f1f1e39e5_b.jpg"
montana_snowbowl.latitude = "47.023999"
montana_snowbowl.longitude = "-113.686864"
montana_snowbowl.resort_link = "http://www.montanasnowbowl.com/"
montana_snowbowl.save!
 
red_lodge = Resort.find_or_initialize_by(id: 90)
red_lodge.base_elevation = "7,016"
red_lodge.summit_elevation = "9,416"
red_lodge.icon = "https://lift.opensnow.com/location-logos/redlodgemountain.png"
red_lodge.image_url = "https://cdn1.coolworks.com/production/clients/24/pictures/20915/content/scenic-limestone-Palisade-rock-formations-Red-Lodge-Mountain-Montana-Ski-Area.jpg"
red_lodge.latitude = "45.190785"
red_lodge.longitude = "-109.336428"
red_lodge.resort_link = "http://www.redlodgemountain.com/"
red_lodge.save!
 
showdown = Resort.find_or_initialize_by(id: 91)
showdown.base_elevation = "6,800"
showdown.summit_elevation = "8,200"
showdown.icon = "https://lift.opensnow.com/location-logos/default_US.png"
showdown.image_url = "https://i.pinimg.com/originals/0b/08/53/0b0853f26ffcc63eaa436bc7d0fc89a0.jpg"
showdown.latitude = "46.838274"
showdown.longitude = "-110.708377"
showdown.resort_link = "http://showdownmontana.com/"
showdown.save!

turner = Resort.find_or_initialize_by(id: 92)
turner.base_elevation = "3,842"
turner.summit_elevation = "5,952"
turner.icon = "https://lift.opensnow.com/location-logos/turnermountain.png"
turner.image_url = "http://explorelibbymontana.com/media/k2/items/cache/62fb5f1024529266c6e71c0c0c9ddb3c_L.jpg"
turner.latitude = "48.604947"
turner.longitude = "-115.630926"
turner.resort_link = "http://www.skiturner.com/"
turner.save!
 
whitefish = Resort.find_or_initialize_by(id: 93)
whitefish.base_elevation = "4,464"
whitefish.summit_elevation = "6,817"
whitefish.icon = "https://lift.opensnow.com/location-logos/whitefishmountain.png"
whitefish.image_url = "https://media.spokesman.com/photos/2016/11/22/SRX_WHITEFISH_3.JPG_t810.jpg?043915c051a7e8a61f3dafe8e38e28c2ebfb384b"
whitefish.latitude = "48.483309"
whitefish.longitude = "-114.358540"
whitefish.resort_link = "http://skiwhitefish.com/"
whitefish.save!
 
yellowstone = Resort.find_or_initialize_by(id: 94)
yellowstone.base_elevation = "7,160"
yellowstone.summit_elevation = "9,859"
yellowstone.icon = "https://lift.opensnow.com/location-logos/yellowstoneclub.png"
yellowstone.image_url = "https://amp.businessinsider.com/images/58502f7aa1a45e46008b57d2-750-375.jpg"
yellowstone.latitude = "45.245841"
yellowstone.longitude = "-111.374457"
yellowstone.resort_link = "http://www.yellowstoneclub.com/"
yellowstone.save!
 
belleayre = Resort.find_or_initialize_by(id: 95)
belleayre.base_elevation = "2,025"
belleayre.summit_elevation = "3,429"
belleayre.icon = "https://lift.opensnow.com/location-logos/belleayre.png"
belleayre.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/12/ae/ce/27/photo0jpg.jpg"
belleayre.latitude = "42.132213"
belleayre.longitude = "-74.505205"
belleayre.resort_link = "http://www.belleayre.com/"
belleayre.save!
 
big_tupper = Resort.find_or_initialize_by(id: 96)
big_tupper.base_elevation = "609"
big_tupper.summit_elevation = "1,082"
big_tupper.icon = "https://lift.opensnow.com/location-logos/bigtupper.png"
big_tupper.image_url = "http://www.backpacktobuggy.com/wp-content/uploads/2010/02/Sun-streaming-through-trees-at-Big-T.jpg"
big_tupper.latitude = "44.169408"
big_tupper.longitude = "-74.479398"
big_tupper.resort_link = "http://skibigtupper.org/"
big_tupper.save!
 
brantling = Resort.find_or_initialize_by(id: 97)
brantling.base_elevation = "600"
brantling.summit_elevation = "850"
brantling.icon = "https://lift.opensnow.com/location-logos/brantling.png"
brantling.image_url = "http://www.newyorkskimaps.com/images/central-ny/Greek_Peak_Ski_Resort.jpg"
brantling.latitude = "43.150040"
brantling.longitude = "-77.065688"
brantling.resort_link = "http://www.brantling.com/"
brantling.save!
 
bristol = Resort.find_or_initialize_by(id: 98)
bristol.base_elevation = "1,000"
bristol.summit_elevation = "2,200"
bristol.icon = "https://lift.opensnow.com/location-logos/bristolmountain.png"
bristol.image_url = "https://i.pinimg.com/originals/36/c3/cd/36c3cd09d7637fcafc30e8bda83ac074.jpg"
bristol.latitude = "42.745113"
bristol.longitude = "-77.404955"
bristol.resort_link = "http://www.bristolmt.com/"
bristol.save!
 
buffalo = Resort.find_or_initialize_by(id: 99)
buffalo.base_elevation = "2,025"
buffalo.summit_elevation = "3,429"
buffalo.icon = "https://lift.opensnow.com/location-logos/buffaloclub.png"
buffalo.image_url = "https://cdn-image.travelandleisure.com/sites/default/files/buffalo-new-york-americas-favorite-ski-destinations-afpski1017.jpg"
buffalo.latitude = "42.680955"
buffalo.longitude = "-78.691922"
buffalo.resort_link = "http://www.bscskiarea.com/"
buffalo.save!
 
dry_hill = Resort.find_or_initialize_by(id: 100)
dry_hill.base_elevation = "650"
dry_hill.summit_elevation = "950"
dry_hill.icon = "https://lift.opensnow.com/location-logos/dryhillny.png"
dry_hill.image_url = "http://www.allegiantairline.net/info/wp-content/uploads/2017/07/dry-hill-ski-area.jpg"
dry_hill.latitude = "43.931033"
dry_hill.longitude = "-75.901467"
dry_hill.resort_link = "http://www.skidryhill.com/"
dry_hill.save!

four_seasons = Resort.find_or_initialize_by(id: 101)
four_seasons.base_elevation = "545"
four_seasons.summit_elevation = "604"
four_seasons.icon = "https://lift.opensnow.com/location-logos/fourseasonsny.png"
four_seasons.image_url = "https://www.outsideonline.com/sites/default/files/styles/img_600x600/public/2019/10/09/tyler-peterson-dropping_s.jpg?itok=sSacXdYg"
four_seasons.latitude = "43.034984"
four_seasons.longitude = "-75.971841"
four_seasons.resort_link = "http://fourseasonsgolfandski.com/"
four_seasons.save!
 
gore = Resort.find_or_initialize_by(id: 102)
gore.base_elevation = "998"
gore.summit_elevation = "3,600"
gore.icon = "https://lift.opensnow.com/location-logos/goremountain.png"
gore.image_url = "https://www.airbnb.com/google_place_photo?photoreference=CmRaAAAAa3PD6B2jyqUE3GH3UPlQcrMPFqy-QUrIXNd92cb0b6hV_0JhWkg423QMYaNFbT6PgLAK8FRJ22nT-UpJH0IUDhJKYcpkfZJ5eVUdJmKH8pdGdnVz9M96VGfePVrt3J5dEhB6TgMfG584DpPcCZSV843GGhT33FWDe82v9KaAqJyvl1XYYJMaXQ&maxwidth=800&maxheight=800&place_id=329668"
gore.latitude = "43.673278"
gore.longitude = "-74.006813"
gore.resort_link = "http://www.goremountain.com/"
gore.save!
 
greek = Resort.find_or_initialize_by(id: 103)
greek.base_elevation = "1,148"
greek.summit_elevation = "2,100"
greek.icon = "https://lift.opensnow.com/location-logos/greekpeak.png"
greek.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/02/41/c4/21/32-trails-of-family-fun.jpg"
greek.latitude = "42.508232"
greek.longitude = "-76.145432"
greek.resort_link = "http://www.greekpeak.net/"
greek.save!
 
hickory = Resort.find_or_initialize_by(id: 104)
hickory.base_elevation = "700"
hickory.summit_elevation = "1,900"
hickory.icon = "https://lift.opensnow.com/location-logos/default_US.png"
hickory.image_url = "https://skimap.org/data/298/1904/1420397685.jpg"
hickory.latitude = "43.474363"
hickory.longitude = "-73.817279"
hickory.resort_link = ""
hickory.save!
 
holiday = Resort.find_or_initialize_by(id: 105)
holiday.base_elevation = "1,150"
holiday.summit_elevation = "1,550"
holiday.icon = "https://lift.opensnow.com/location-logos/holidaymountainfunpark.png"
holiday.image_url = "https://www.skimag.com/.image/ar_16:9%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_768/MTUwMTIxODU0MTg5NzA5MDg0/ski1017_rge_holidayvalleycourtesy.jpg"
holiday.latitude = "41.629528"
holiday.longitude = "-74.614447"
holiday.resort_link = "http://www.holidaymtn.com/"
holiday.save!

holiday_valley = Resort.find_or_initialize_by(id: 106)
holiday_valley.base_elevation = "1,500"
holiday_valley.summit_elevation = "2,250"
holiday_valley.icon = "https://lift.opensnow.com/location-logos/holidayvalley.png"
holiday_valley.image_url = "http://www.ellicottvilletimes.com/wp-content/uploads/2016/10/hv.jpg"
holiday_valley.latitude = "42.262631"
holiday_valley.longitude = "-78.667440"
holiday_valley.resort_link = "http://www.holidayvalley.com/"
holiday_valley.save!

holimont = Resort.find_or_initialize_by(id: 107)
holimont.base_elevation = "1,560"
holimont.summit_elevation = "2,260"
holimont.icon = "https://lift.opensnow.com/location-logos/holimont.png"
holimont.image_url = "https://img1.onthesnow.com/image/xl/51/5136.jpg"
holimont.latitude = "42.273224"
holimont.longitude = "-78.689164"
holimont.resort_link = "http://www.holimont.com/"
holimont.save!
 
hunter = Resort.find_or_initialize_by(id: 108)
hunter.base_elevation = "1,600"
hunter.summit_elevation = "3,200"
hunter.icon = "https://lift.opensnow.com/location-logos/huntermountain.png"
hunter.image_url = "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Flarryolmsted%2Ffiles%2F2018%2F08%2FHunterMtn.jpg"
hunter.latitude = "42.177738"
hunter.longitude = "-74.230722"
hunter.resort_link = "https://www.huntermtn.com"
hunter.save!
 
kissing = Resort.find_or_initialize_by(id: 109)
kissing.base_elevation = "1,150"
kissing.summit_elevation = "1,700"
kissing.icon = "https://lift.opensnow.com/location-logos/kissingbridge.png"
kissing.image_url = "https://www.visitbuffaloniagara.com/content/uploads/2018/02/KB_10.jpg"
kissing.latitude = "42.600153"
kissing.longitude = "-78.652666"
kissing.resort_link = "http://www.kbski.com/"
kissing.save!
 
labrador = Resort.find_or_initialize_by(id: 110)
labrador.base_elevation = "1,125"
labrador.summit_elevation = "1,825"
labrador.icon = "https://lift.opensnow.com/location-logos/labrador.png"
labrador.image_url = "https://alumni.cornell.edu/wp-content/uploads/2018/02/skiing.jpg"
labrador.latitude = "42.741775"
labrador.longitude = "-76.030258"
labrador.resort_link = "https://www.skicny.com/"
labrador.save!
 
maple = Resort.find_or_initialize_by(id: 111)
maple.base_elevation = "750"
maple.summit_elevation = "1,200"
maple.icon = "https://lift.opensnow.com/location-logos/mapleridge.png"
maple.image_url = "https://dailygazette.com/sites/default/files/styles/article_image/public/MapleSkiRidgeOPEN80.jpg?itok=JjV89_0t"
maple.latitude = "42.817705"
maple.longitude = "-74.031713"
maple.resort_link = "http://winter.mapleskiridge.com/"
maple.save!
 
mccauley = Resort.find_or_initialize_by(id: 112)
mccauley.base_elevation = "1,563"
mccauley.summit_elevation = "2,250"
mccauley.icon = "https://lift.opensnow.com/location-logos/mccauleymtn.png"
mccauley.image_url = "https://www.sefiles.net/merchant/704/images/site/McCAULEYSKIPICS.jpg"
mccauley.latitude = "43.697190"
mccauley.longitude = "-74.965962"
mccauley.resort_link = "http://www.mccauleyny.com/"
mccauley.save!
 
peter = Resort.find_or_initialize_by(id: 113)
peter.base_elevation = "750"
peter.summit_elevation = "1,250"
peter.icon = "https://lift.opensnow.com/location-logos/mtpeter.png"
peter.image_url = "https://usatunofficial.files.wordpress.com/2015/10/mt-peter.jpg"
peter.latitude = "41.247711"
peter.longitude = "-74.295144"
peter.resort_link = "http://mtpeter.com/"
peter.save!
 
oak = Resort.find_or_initialize_by(id: 114)
oak.base_elevation = "1,750"
oak.summit_elevation = "2,400"
oak.icon = "https://lift.opensnow.com/location-logos/oakmtny.png"
oak.image_url = "https://res.cloudinary.com/liftopia/image/upload/c_fit,d_defaults:default_logo_1.png,f_auto,h_980,q_auto,w_980/v1/production/trail_maps/6c9f6a9227a6d1f7d14598c8f5f27a8f.jpg"
oak.latitude = "43.518044"
oak.longitude = "-74.362140"
oak.resort_link = "http://oakmountainski.com/oak/"
oak.save!
 
peek = Resort.find_or_initialize_by(id: 115)
peek.base_elevation = "1,400"
peek.summit_elevation = "1,800"
peek.icon = "https://lift.opensnow.com/location-logos/peeknpeakresort.png"
peek.image_url = "https://skimap.org/data/302/7/1238878089.gif"
peek.latitude = "42.062322"
peek.longitude = "-79.735476"
peek.resort_link = "http://www.pknpk.com/"
peek.save!
 
plattekill = Resort.find_or_initialize_by(id: 116)
plattekill.base_elevation = "2,400"
plattekill.summit_elevation = "3,500"
plattekill.icon = "https://lift.opensnow.com/location-logos/plattekill.png"
plattekill.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/01/b8/29/0b/ski-plattekill-mountain.jpg"
plattekill.latitude = "42.290325"
plattekill.longitude = "-74.653246"
plattekill.resort_link = "http://www.plattekill.com/winter/"
plattekill.save!
 
royal = Resort.find_or_initialize_by(id: 117)
royal.base_elevation = "1,250"
royal.summit_elevation = "1,800"
royal.icon = "https://lift.opensnow.com/location-logos/royalmtnny.png"
royal.image_url = "https://s3.onthesnow.com/images/trailmaps/new-york/royal-mountain-ski-area/20190219184010/large.jpg"
royal.latitude = "43.081270"
royal.longitude = "-74.504878"
royal.resort_link = "http://royalmountain.com/"
royal.save!
 
sawkill = Resort.find_or_initialize_by(id: 118)
sawkill.base_elevation = "588"
sawkill.summit_elevation = "658"
sawkill.icon = "https://lift.opensnow.com/location-logos/sawkillnyc.png"
sawkill.image_url = "http://www.skibum.net/wp/wp-content/uploads/2016/10/gore.jpg"
sawkill.latitude = "41.985191"
sawkill.longitude = "-74.043702"
sawkill.resort_link = "https://www.iskiny.com/mountains/sawkill-family-ski-center"
sawkill.save!
 
snow_ridge = Resort.find_or_initialize_by(id: 119)
snow_ridge.base_elevation = "1,350"
snow_ridge.summit_elevation = "2,000"
snow_ridge.icon = "https://lift.opensnow.com/location-logos/snowridge.png"
snow_ridge.image_url = "https://q-cf.bstatic.com/images/hotel/max1024x768/113/113322101.jpg"
snow_ridge.latitude = "43.639779"
snow_ridge.longitude = "-75.420123"
snow_ridge.resort_link = "http://snowridge.com/"
snow_ridge.save!
 
song = Resort.find_or_initialize_by(id: 120)
song.base_elevation = "1,240"
song.summit_elevation = "1,940"
song.icon = "https://lift.opensnow.com/location-logos/songmountain.png"
song.image_url = "https://res.cloudinary.com/liftopia/image/upload/c_fit,d_defaults:default_logo_1.png,f_auto,h_980,q_auto,w_980/v1/production/trail_maps/81dde1bca12e9319e090c9d34c0afa32.jpg"
song.latitude = "42.773784"
song.longitude = "-76.157015"
song.resort_link = "https://www.skicny.com/"
song.save!
 
swain = Resort.find_or_initialize_by(id: 121)
swain.base_elevation = "1,320"
swain.summit_elevation = "1,970"
swain.icon = "https://lift.opensnow.com/location-logos/swainresort.png"
swain.image_url = "https://www.goremountain.com/sites/default/files/styles/600x400_potd/public/swain_mountain_extra_0.jpg?itok=ZHSwRxaM"
swain.latitude = "42.476511"
swain.longitude = "-77.855036"
swain.resort_link = "http://www.swain.com/"
swain.save!
 
thunder = Resort.find_or_initialize_by(id: 122)
thunder.base_elevation = "770"
thunder.summit_elevation = "1,270"
thunder.icon = "https://lift.opensnow.com/location-logos/thunderridge.png"
thunder.image_url = "https://s3.onthesnow.com/images/trailmaps/new-york/thunder-ridge/20150210130442/xlarge.jpg"
thunder.latitude = "41.508588"
thunder.longitude = "-73.584900"
thunder.resort_link = "http://thunderridgeski.com/"
thunder.save!
 
titus = Resort.find_or_initialize_by(id: 123)
titus.base_elevation = "825"
titus.summit_elevation = "2,025"
titus.icon = "https://lift.opensnow.com/location-logos/titusmountain.png"
titus.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/02/58/b0/29/titus-mountain.jpg"
titus.latitude = "44.766604"
titus.longitude = "-74.232912"
titus.resort_link = "http://www.titusmountain.com/"
titus.save!
 
toggenburg = Resort.find_or_initialize_by(id: 124)
toggenburg.base_elevation = "1,300"
toggenburg.summit_elevation = "2,000"
toggenburg.icon = "https://lift.opensnow.com/location-logos/toggenburg.png"
toggenburg.image_url = "https://uploads-ssl.webflow.com/5baaa0e48008113f47c4ce2b/5bba953582df35b03eb4f0fd_toggenburg%20mountain%20crowd.jpg"
toggenburg.latitude = "42.826150"
toggenburg.longitude = "-75.959821"
toggenburg.resort_link = "http://www.skitog.com/"
toggenburg.save!

tuxedo = Resort.find_or_initialize_by(id: 125)
tuxedo.base_elevation = "800"
tuxedo.summit_elevation = "1,200"
tuxedo.icon = "https://lift.opensnow.com/location-logos/tuxedoridge.png"
tuxedo.image_url = "http://whitebookski.com/wp-content/uploads/2017/04/Mt_Peter_480195_i0.jpg"
tuxedo.latitude = "41.248181"
tuxedo.longitude = "-74.226981"
tuxedo.resort_link = "http://www.tuxedoridge.com/"
tuxedo.save!
 
west_mountain = Resort.find_or_initialize_by(id: 126)
west_mountain.base_elevation = "460"
west_mountain.summit_elevation = "1,470"
west_mountain.icon = "https://lift.opensnow.com/location-logos/westmountain.png"
west_mountain.image_url = "https://images.fineartamerica.com/images-medium-large-5/west-mountain-ski-area-sandie-keyser.jpg"
west_mountain.latitude = "43.285614"
west_mountain.longitude = "-73.725249"
west_mountain.resort_link = "http://www.skiwestmountain.com/"
west_mountain.save!

whiteface = Resort.find_or_initialize_by(id: 127)
whiteface.base_elevation = "1,220"
whiteface.summit_elevation = "4,650"
whiteface.icon = "https://lift.opensnow.com/location-logos/whiteface.png"
whiteface.image_url = "https://www.tripsavvy.com/thmb/QTTLcpCj6BUgaFeQKQglrC1D9e0=/960x0/filters:no_upscale():max_bytes(150000):strip_icc()/whiteface-5a314e08b39d030037bdedc3.jpg"
whiteface.latitude = "44.353590"
whiteface.longitude = "-73.861438"
whiteface.resort_link = "http://whiteface.com/"
whiteface.save!
 
willard = Resort.find_or_initialize_by(id: 128)
willard.base_elevation = "910"
willard.summit_elevation = "1,415"
willard.icon = "https://lift.opensnow.com/location-logos/willardmountain.png"
willard.image_url = "https://irp-cdn.multiscreensite.com/d13eefc0/dms3rep/multi/WILLARD+web-08292017.png"
willard.latitude = "43.020649"
willard.longitude = "-73.515817"
willard.resort_link = "http://www.willardmountain.com/"
willard.save!
 
windham = Resort.find_or_initialize_by(id: 129)
windham.base_elevation = "1,500"
windham.summit_elevation = "3,100"
windham.icon = "https://lift.opensnow.com/location-logos/windham.png"
windham.image_url = "https://s3-us-west-2.amazonaws.com/ncs-ons10-us-west-2-159685838580-content-prd/ns1or_wt1_p/s3fs-public/styles/cf_story_full_content/public/Image_cont_a7c4df65c393a916acfcaf815490228aa71695ff.jpeg?Aclf3zhKWCKrkl.ihPSA_kGegVGIRnK_&itok=Ahqe6Pv2"
windham.latitude = "42.293814"
windham.longitude = "-74.256529"
windham.resort_link = "http://www.windhammountain.com/"
windham.save!
 
woods_valley = Resort.find_or_initialize_by(id: 130)
woods_valley.base_elevation = "900"
woods_valley.summit_elevation = "1,400"
woods_valley.icon = "https://lift.opensnow.com/location-logos/woodsvalley.png"
woods_valley.image_url = "https://res.cloudinary.com/liftopia/image/upload/c_fit,d_defaults:default_logo_1.png,f_auto,h_980,q_auto,w_980/v1/production/trail_maps/12293e90fd547893e1386965beaab242.png"
woods_valley.latitude = "43.302597"
woods_valley.longitude = "-75.384600"
woods_valley.resort_link = "http://www.woodsvalleyskiarea.com/"
woods_valley.save!
 
alta = Resort.find_or_initialize_by(id: 131)
alta.base_elevation = "8,530"
alta.summit_elevation = "11,068"
alta.icon = "https://lift.opensnow.com/location-logos/alta.png"
alta.image_url = "https://cdn.visitutah.com/media/15892940/web2000_alta_misc_alta_2017_2634-144dpi.jpg?anchor=center&mode=crop&width=1140&height=760&rnd=131877747190000000&quality=86"
alta.latitude = "40.588315"
alta.longitude = "-111.636556"
alta.resort_link = "https://www.alta.com"
alta.save!
 
beaver_mountain = Resort.find_or_initialize_by(id: 132)
beaver_mountain.base_elevation = "7,232"
beaver_mountain.summit_elevation = "8,860"
beaver_mountain.icon = "https://lift.opensnow.com/location-logos/beavermountain.png"
beaver_mountain.image_url = "https://cdn.visitutah.com/media/15892973/web2000_beavermountain_rewikstrom_170326_4510.jpg?anchor=center&mode=crop&width=1140&height=760&rnd=131877750530000000&quality=86"
beaver_mountain.latitude = "41.968059"
beaver_mountain.longitude = "-111.544026"
beaver_mountain.resort_link = "http://www.skithebeav.com/"
beaver_mountain.save!
 
brian_head = Resort.find_or_initialize_by(id: 133)
brian_head.base_elevation = "9,600"
brian_head.summit_elevation = "10,970"
brian_head.icon = "https://lift.opensnow.com/location-logos/brianhead.png"
brian_head.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/06/69/42/28/brian-head-resort.jpg"
brian_head.latitude = "37.702839"
brian_head.longitude = "-112.849654"
brian_head.resort_link = "https://www.brianhead.com/"
brian_head.save!
 
brighton = Resort.find_or_initialize_by(id: 134)
brighton.base_elevation = "8,755"
brighton.summit_elevation = "10,500"
brighton.icon = "https://lift.opensnow.com/location-logos/brighton.png"
brighton.image_url = "http://www.skicentral.com/assets/images/trailmaps/801003-1200.jpg"
brighton.latitude = "40.598715"
brighton.longitude = "-111.582768"
brighton.resort_link = "http://www.brightonresort.com/"
brighton.save!
 
deer_valley = Resort.find_or_initialize_by(id: 135)
deer_valley.base_elevation = "6,570"
deer_valley.summit_elevation = "9,570"
deer_valley.icon = "https://lift.opensnow.com/location-logos/deervalley.png"
deer_valley.image_url = "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F583789969%2F960x0.jpg%3Ffit%3Dscale"
deer_valley.latitude = "40.637307"
deer_valley.longitude = "-111.478424"
deer_valley.resort_link = "http://www.deervalley.com/"
deer_valley.save!

eagle_point = Resort.find_or_initialize_by(id: 136)
eagle_point.base_elevation = "9,100"
eagle_point.summit_elevation = "10,600"
eagle_point.icon = "https://lift.opensnow.com/location-logos/eaglepoint.png"
eagle_point.image_url = "https://www.eaglepointresort.com/sites/default/files/trail_map_2018_2-large.jpg"
eagle_point.latitude = "38.320581"
eagle_point.longitude = "-112.383871"
eagle_point.resort_link = "http://www.skieaglepoint.com/"
eagle_point.save!
 
nordic_valley = Resort.find_or_initialize_by(id: 137)
nordic_valley.base_elevation = "5,440"
nordic_valley.summit_elevation = "6,400"
nordic_valley.icon = "https://lift.opensnow.com/location-logos/wolfcreekutah.png"
nordic_valley.image_url = "https://bloximages.newyork1.vip.townnews.com/standard.net/content/tncms/assets/v3/editorial/b/55/b558307e-b1c1-5535-9865-99f3416e3a03/5b528867d1924.image.png"
nordic_valley.latitude = "41.310363"
nordic_valley.longitude = "-111.864834"
nordic_valley.resort_link = "https://nordicvalley.com"
nordic_valley.save!
 
park_city = Resort.find_or_initialize_by(id: 138)
park_city.base_elevation = "6,800"
park_city.summit_elevation = "10,000"
park_city.icon = "https://lift.opensnow.com/location-logos/parkcity.png"
park_city.image_url = "https://images.vailresorts.com/image/upload/c_scale,dpr_3.0,f_auto,q_auto,w_500/v1/Park%20City/Products/lodging/Lodging_600x360.jpg"
park_city.latitude = "40.653552"
park_city.longitude = "-111.509851"
park_city.resort_link = "https://www.parkcitymountain.com/"
park_city.save!

powder_mountain = Resort.find_or_initialize_by(id: 139)
powder_mountain.base_elevation = "6,900"
powder_mountain.summit_elevation = "9,422"
powder_mountain.icon = "https://lift.opensnow.com/location-logos/powmow.png"
powder_mountain.image_url = "https://cdn.visitutah.com/media/15893088/web2000_powdermountain2__jwp9799.jpg?center=0.560975609756098,0.821138211382114&mode=crop&width=1140&height=760&rnd=131877752740000000&quality=86"
powder_mountain.latitude = "41.379003"
powder_mountain.longitude = "-111.780792"
powder_mountain.resort_link = "http://powdermountain.com/"
powder_mountain.save!

cherry = Resort.find_or_initialize_by(id: 140)
cherry.base_elevation = "5,775"
cherry.summit_elevation = "7,050"
cherry.icon = "https://lift.opensnow.com/location-logos/skicherrypeak.png"
cherry.image_url = "https://img-aws.ehowcdn.com/700x/cdn.onlyinyourstate.com/wp-content/uploads/2018/01/23435086_1480227122015055_509837987264931321_n-700x467.jpg"
cherry.latitude = "41.926533"
cherry.longitude = "-111.756267"
cherry.resort_link = "http://www.skicpr.com/"
cherry.save!
 
snowbasin = Resort.find_or_initialize_by(id: 141)
snowbasin.base_elevation = "6,450"
snowbasin.summit_elevation = "9,350"
snowbasin.icon = "https://lift.opensnow.com/location-logos/snowbasin.png"
snowbasin.image_url = "https://www.mountainluxurylodging.com/wp-content/uploads/2018/11/snowbasin.jpg"
snowbasin.latitude = "41.215916"
snowbasin.longitude = "-111.856972"
snowbasin.resort_link = "https://www.snowbasin.com"
snowbasin.save!
 
snowbird = Resort.find_or_initialize_by(id: 142)
snowbird.base_elevation = "7,760"
snowbird.summit_elevation = "11,000"
snowbird.icon = "https://lift.opensnow.com/location-logos/snowbird.png"
snowbird.image_url = "https://cdn3.volusion.com/2xsju.tuv9z/v/vspfiles/photos/poster-ta-snowbird-2.jpg?v-cache=1557153724"
snowbird.latitude = "40.581082"
snowbird.longitude = "-111.656416"
snowbird.resort_link = "http://www.snowbird.com/"
snowbird.save!
 
solitude = Resort.find_or_initialize_by(id: 143)
solitude.base_elevation = "7,994"
solitude.summit_elevation = "10,488"
solitude.icon = "https://lift.opensnow.com/location-logos/solitude.png"
solitude.image_url = "https://i2.wp.com/www.snowsbest.com/wp-content/uploads/2016/12/Solitude-Mountain-Resort-Skiing_2.jpg?fit=1019%2C676&ssl=1"
solitude.latitude = "40.619160"
solitude.longitude = "-111.593505"
solitude.resort_link = "http://www.skisolitude.com/"
solitude.save!
 
sundance = Resort.find_or_initialize_by(id: 144)
sundance.base_elevation = "6,100"
sundance.summit_elevation = "8,250"
sundance.icon = "https://lift.opensnow.com/location-logos/sundance.png"
sundance.image_url = "https://img5.onthesnow.com/image/xl/11/1186.jpg"
sundance.latitude = "40.391444"
sundance.longitude = "-111.578255"
sundance.resort_link = "http://sundanceresort.com/"
sundance.save!
 
bolton = Resort.find_or_initialize_by(id: 145)
bolton.base_elevation = "1,446"
bolton.summit_elevation = "3,150"
bolton.icon = "https://lift.opensnow.com/location-logos/boltonvalley.png"
bolton.image_url = "https://www.boltonvalley.com/upload/content/bv_backcountry/hiking.jpg"
bolton.latitude = "44.420998"
bolton.longitude = "-72.850269"
bolton.resort_link = "http://www.boltonvalley.com/"
bolton.save!
 
bromley = Resort.find_or_initialize_by(id: 146)
bromley.base_elevation = "1,950"
bromley.summit_elevation = "3,284"
bromley.icon = "https://lift.opensnow.com/location-logos/bromley.png"
bromley.image_url = "https://www.snow-forecast.com/pistemaps/Bromley-Mountain_pistemap.jpg"
bromley.latitude = "43.213446"
bromley.longitude = "-72.934963"
bromley.resort_link = "http://www.bromley.com/"
bromley.save!

burke = Resort.find_or_initialize_by(id: 147)
burke.base_elevation = "1,210"
burke.summit_elevation = "3,267"
burke.icon = "https://lift.opensnow.com/location-logos/burkemountain.png"
burke.image_url = "http://www.firsttracksonline.com/wp-content/uploads/2012/04/burkemountain.jpg"
burke.latitude = "44.570859"
burke.longitude = "-71.893174"
burke.resort_link = "http://www.skiburke.com/"
burke.save!
 
jay_peak = Resort.find_or_initialize_by(id: 148)
jay_peak.base_elevation = "1,815"
jay_peak.summit_elevation = "3,968"
jay_peak.icon = "https://lift.opensnow.com/location-logos/jaypeak.png"
jay_peak.image_url = "https://static.evo.com/content/travel-guides/vermont/jay-peak/feb10_tramgoat__large.jpg"
jay_peak.latitude = "44.937861"
jay_peak.longitude = "-72.504479"
jay_peak.resort_link = "http://www.jaypeakresort.com/"
jay_peak.save!
 
killington = Resort.find_or_initialize_by(id: 149)
killington.base_elevation = "1,165"
killington.summit_elevation = "4,241"
killington.icon = "https://lift.opensnow.com/location-logos/killington.png"
killington.image_url = "https://mediad.publicbroadcasting.net/p/vpr/files/styles/x_large/public/201810/Killington-Martha-Howe-courtesy-101818.jpg"
killington.latitude = "43.625482"
killington.longitude = "-72.797153"
killington.resort_link = "https://www.killington.com/"
killington.save!
 
mad_river = Resort.find_or_initialize_by(id: 150)
mad_river.base_elevation = "1,600"
mad_river.summit_elevation = "3,637"
mad_river.icon = "https://lift.opensnow.com/location-logos/madriverglen.png"
mad_river.image_url = "http://snowbrains.com/wp-content/uploads/2017/08/1743582_10152900266485432_1953371606710527852_n-min.jpg"
mad_river.latitude = "44.202451"
mad_river.longitude = "-72.917640"
mad_river.resort_link = "http://www.madriverglen.com/"
mad_river.save!
 
magic_mountain = Resort.find_or_initialize_by(id: 151)
magic_mountain.base_elevation = "1,350"
magic_mountain.summit_elevation = "2,850"
magic_mountain.icon = "https://lift.opensnow.com/location-logos/magicmountainvt.png"
magic_mountain.image_url = "https://img6.onthesnow.com/image/xl/80/8051.jpg"
magic_mountain.latitude = "43.201724"
magic_mountain.longitude = "-72.772635"
magic_mountain.resort_link = "http://www.magicmtn.com/"
magic_mountain.save!
 
middlebury = Resort.find_or_initialize_by(id: 152)
middlebury.base_elevation = "1,720"
middlebury.summit_elevation = "2,720"
middlebury.icon = "https://lift.opensnow.com/location-logos/middleburysnowbowl.png"
middlebury.image_url = "https://www.skimaven.com/uploads/pics/midd-1-23-10-2_01.jpg"
middlebury.latitude = "43.939345"
middlebury.longitude = "-72.957466"
middlebury.resort_link = "http://www.middlebury.edu/about/facilities/snow_bowl"
middlebury.save!
 
mount_snow = Resort.find_or_initialize_by(id: 153)
mount_snow.base_elevation = "1,900"
mount_snow.summit_elevation = "3,600"
mount_snow.icon = "https://lift.opensnow.com/location-logos/mountsnow.png"
mount_snow.image_url = "https://berkleyveller.com/wp-content/uploads/2019/01/DSC_6019_Snapseed-1024x680.jpg"
mount_snow.latitude = "42.965981"
mount_snow.longitude = "-72.894324"
mount_snow.resort_link = "http://mountsnow.com/"
mount_snow.save!

okemo = Resort.find_or_initialize_by(id: 154)
okemo.base_elevation = "1,144"
okemo.summit_elevation = "3,344"
okemo.icon = "https://lift.opensnow.com/location-logos/okemo.png"
okemo.image_url = "https://www.skimag.com/.image/ar_16:9%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_768/MTY3OTU5MTIxMjY4NTgxNzYw/ski1119-rge-okemo-courtesy.jpg"
okemo.latitude = "43.402104"
okemo.longitude = "-72.718354"
okemo.resort_link = "http://okemo.com/"
okemo.save!
 
pico = Resort.find_or_initialize_by(id: 155)
pico.base_elevation = "1,967"
pico.summit_elevation = "3,967"
pico.icon = "https://lift.opensnow.com/location-logos/picovt.png"
pico.image_url = "https://vtskiandride.com/wp-content/uploads/2018/08/unnamed.png"
pico.latitude = "43.661980"
pico.longitude = "-72.842341"
pico.resort_link = "http://www.picomountain.com/winter/index.html"
pico.save!
 
quechee = Resort.find_or_initialize_by(id: 156)
quechee.base_elevation = "600"
quechee.summit_elevation = "1,250"
quechee.icon = "https://lift.opensnow.com/location-logos/quecheeclub.png"
quechee.image_url = "https://www.woodstockvt.com/sites/default/files/styles/hero_x_large/public/media-images/Suicide6aerial1920.jpg?itok=hpZ5I1Rd"
quechee.latitude = "43.657136"
quechee.longitude = "-72.442819"
quechee.resort_link = "http://www.quecheeclub.com/club/scripts/section/section.asp?NS=WINTER_VT"
quechee.save!
 
smuggler = Resort.find_or_initialize_by(id: 157)
smuggler.base_elevation = "1,030"
smuggler.summit_elevation = "3,640"
smuggler.icon = "https://lift.opensnow.com/location-logos/smugglersnotch.png"
smuggler.image_url = "https://i.pinimg.com/originals/95/61/e6/9561e676f3a83e171bb1eeb95fcdcbe5.jpg"
smuggler.latitude = "44.588717"
smuggler.longitude = "-72.789494"
smuggler.resort_link = "http://www.smuggs.com/"
smuggler.save!
 
stowe = Resort.find_or_initialize_by(id: 158)
stowe.base_elevation = "2,035"
stowe.summit_elevation = "4,395"
stowe.icon = "https://lift.opensnow.com/location-logos/stowe.png"
stowe.image_url = "https://teresastowe.files.wordpress.com/2015/12/2015-12-19-spruce-peak-tree.jpg"
stowe.latitude = "44.531290"
stowe.longitude = "-72.780844"
stowe.resort_link = "http://www.stowe.com/"
stowe.save!
 
stratton = Resort.find_or_initialize_by(id: 159)
stratton.base_elevation = "1,872"
stratton.summit_elevation = "3,875"
stratton.icon = "https://lift.opensnow.com/location-logos/stratton.png"
stratton.image_url = "https://www.stratton.com/-/media/stratton/images/winter/768x604/landscape/big-mtn/2015-16/161009_bigmtn_768x604_8.ashx?h=604&w=768&hash=894526306588132E812C92B8B3A4962505EE44B2"
stratton.latitude = "43.095540"
stratton.longitude = "-72.920677"
stratton.resort_link = "http://www.stratton.com/"
stratton.save!
 
sugarbush = Resort.find_or_initialize_by(id: 160)
sugarbush.base_elevation = "1,483"
sugarbush.summit_elevation = "4,083"
sugarbush.icon = "https://lift.opensnow.com/location-logos/sugarbush.png"
sugarbush.image_url = "https://www.theroundbarn.com/wp-content/uploads/2013/06/img10.jpg"
sugarbush.latitude = "44.135682"
sugarbush.longitude = "-72.892400"
sugarbush.resort_link = "http://www.sugarbush.com/"
sugarbush.save!
 
suicide = Resort.find_or_initialize_by(id: 161)
suicide.base_elevation = "550"
suicide.summit_elevation = "1,200"
suicide.icon = "https://lift.opensnow.com/location-logos/suicidesix.png"
suicide.image_url = "https://www.woodstockvt.com/sites/default/files/styles/hero_x_large/public/media-images/S64000cw_0.jpg?itok=OTnX2WyQ"
suicide.latitude = "43.665030"
suicide.longitude = "-72.543330"
suicide.resort_link = "http://www.suicide6.com"
suicide.save!
 
degrees = Resort.find_or_initialize_by(id: 162)
degrees.base_elevation = "3,932"
degrees.summit_elevation = "5,774"
degrees.icon = "https://lift.opensnow.com/location-logos/49degreesnorth.png"
degrees.image_url = "https://s22867.pcdn.co/wp-content/uploads/2019/04/55564535_2358981154120630_708228996030005248_o.jpg"
degrees.latitude = "48.301176"
degrees.longitude = "-117.562948"
degrees.resort_link = "http://www.ski49n.com/"
degrees.save!
 
bluewood = Resort.find_or_initialize_by(id: 163)
bluewood.base_elevation = "4,545"
bluewood.summit_elevation = "5,670"
bluewood.icon = "https://lift.opensnow.com/location-logos/bluewood.png"
bluewood.image_url = "https://www.wallawalla.org/wp-content/uploads/2018/01/Pu6wt46aQQ6I8KBUdbm9_full_01_Cowboy-Ridge-at-Stevens-Pass-e1515539039841.jpg"
bluewood.latitude = "46.082405"
bluewood.longitude = "-117.851242"
bluewood.resort_link = "http://www.bluewood.com/"
bluewood.save!
 
crystal = Resort.find_or_initialize_by(id: 164)
crystal.base_elevation = "4,400"
crystal.summit_elevation = "7,012"
crystal.icon = "https://lift.opensnow.com/location-logos/crystalmountain.png"
crystal.image_url = "https://visitrainier.com/wp-content/uploads/2018/12/coCrystalCrystal_Mountain_Resort_4x61.jpg"
crystal.latitude = "46.928371"
crystal.longitude = "-121.503720"
crystal.resort_link = "http://www.crystalmountainresort.com/"
crystal.save!
 
hurricane = Resort.find_or_initialize_by(id: 165)
hurricane.base_elevation = "4,800"
hurricane.summit_elevation = "5,242"
hurricane.icon = "https://lift.opensnow.com/location-logos/hurricaneridge.png"
hurricane.image_url = "https://hurricaneridge.com/wp-content/uploads/2017/03/16997965_10156107694092037_882107845597988552_n.jpg"
hurricane.latitude = "47.969963"
hurricane.longitude = "-123.495157"
hurricane.resort_link = "http://hurricaneridge.com/"
hurricane.save!
 
loup_loup = Resort.find_or_initialize_by(id: 166)
loup_loup.base_elevation = "4,060"
loup_loup.summit_elevation = "5,280"
loup_loup.icon = "https://lift.opensnow.com/location-logos/louploupskibowl.png"
loup_loup.image_url = "https://static.wixstatic.com/media/0b6e2f_f749e5058ee944c09743c5ead47f1ae4.jpg/v1/fill/w_783,h_524,al_c,q_90,usm_0.66_1.00_0.01/0b6e2f_f749e5058ee944c09743c5ead47f1ae4.webp"
loup_loup.latitude = "48.394383"
loup_loup.longitude = "-119.910991"
loup_loup.resort_link = "http://www.skitheloup.com/"
loup_loup.save!
 
mission = Resort.find_or_initialize_by(id: 167)
mission.base_elevation = "4,570"
mission.summit_elevation = "6,820"
mission.icon = "https://lift.opensnow.com/location-logos/missionridge.png"
mission.image_url = "https://media-cdn.tripadvisor.com/media/photo-s/03/9c/5d/05/mission-ridge-ski-and.jpg"
mission.latitude = "47.291869"
mission.longitude = "-120.399506"
mission.resort_link = "http://www.missionridge.com/"
mission.save!
 
mt_baker = Resort.find_or_initialize_by(id: 168)
mt_baker.base_elevation = "3,500"
mt_baker.summit_elevation = "5,000"
mt_baker.icon = "https://lift.opensnow.com/location-logos/mtbaker.png"
mt_baker.image_url = "https://i.pinimg.com/originals/21/8e/94/218e9419723d56ed7473dc0e6f0a4a9d.jpg"
mt_baker.latitude = "48.856873"
mt_baker.longitude = "-121.665210"
mt_baker.resort_link = "http://www.mtbaker.us/"
mt_baker.save!
 
spokane = Resort.find_or_initialize_by(id: 169)
spokane.base_elevation = "4,200"
spokane.summit_elevation = "5,889"
spokane.icon = "https://lift.opensnow.com/location-logos/mtspokane.png"
spokane.image_url = "https://media1.fdncms.com/inlander/imager/u/original/18427904/snowlander4-1-081a5b63d1440e03.jpg"
spokane.latitude = "47.921346"
spokane.longitude = "-117.096427"
spokane.resort_link = "http://www.mtspokane.com/"
spokane.save!
 
cascade_heli = Resort.find_or_initialize_by(id: 170)
cascade_heli.base_elevation = "4,800"
cascade_heli.summit_elevation = "8,600"
cascade_heli.icon = "https://lift.opensnow.com/location-logos/northcascadeheli.png"
cascade_heli.image_url = "https://www.heli-ski.com/sites/default/files/inline-images/nch37_1.jpg"
cascade_heli.latitude = "48.596290"
cascade_heli.longitude = "-120.442574"
cascade_heli.resort_link = "http://www.heli-ski.com/"
cascade_heli.save!
 
stevens = Resort.find_or_initialize_by(id: 171)
stevens.base_elevation = "4,061"
stevens.summit_elevation = "5,845"
stevens.icon = "https://lift.opensnow.com/location-logos/stevenspass.png"
stevens.image_url = "https://images.vailresorts.com/image/upload/ar_4:3,c_fill,dpr_3.0,f_auto,g_auto,q_auto/v1/Stevens%20Pass/Heros/Brochure/Explore%20the%20Resort/About%20the%20Resort/Photos%20and%20Videos/photos%20and%20vid%20hero.jpg"
stevens.latitude = "47.744136"
stevens.longitude = "-121.090123"
stevens.resort_link = "http://www.stevenspass.com/"
stevens.save!
 
snoqualmie_alpental = Resort.find_or_initialize_by(id: 172)
snoqualmie_alpental.base_elevation = "2,840"
snoqualmie_alpental.summit_elevation = "3,865"
snoqualmie_alpental.icon = "https://lift.opensnow.com/location-logos/summitatsnoqualmiealpental.png"
snoqualmie_alpental.image_url = "https://img1.onthesnow.com/image/xl/60/6072.jpg"
snoqualmie_alpental.latitude = "47.420382"
snoqualmie_alpental.longitude = "-121.421255"
snoqualmie_alpental.resort_link = "http://www.summitatsnoqualmie.com/"
snoqualmie_alpental.save!
 
snoqualmie_east = Resort.find_or_initialize_by(id: 173)
snoqualmie_east.base_elevation = "2,840"
snoqualmie_east.summit_elevation = "3,865"
snoqualmie_east.icon = "https://lift.opensnow.com/location-logos/summitatsnoqualmieeast.png"
snoqualmie_east.image_url = "https://skiliftblog.files.wordpress.com/2015/09/img_3932.jpg"
snoqualmie_east.latitude = "47.390257"
snoqualmie_east.longitude = "-121.396399"
snoqualmie_east.resort_link = "http://www.summitatsnoqualmie.com/"
snoqualmie_east.save!
 
snoqualmie_west = Resort.find_or_initialize_by(id: 174)
snoqualmie_west.base_elevation = "2,840"
snoqualmie_west.summit_elevation = "3,865"
snoqualmie_west.icon = "https://lift.opensnow.com/location-logos/summitatsnoqualmiewest.png"
snoqualmie_west.image_url = "https://www.mountaineers.org/activities/activities/backcountry-ski-snowboard-snoqualmie-mountain-11/@@images/image"
snoqualmie_west.latitude = "47.424523"
snoqualmie_west.longitude = "-121.416556"
snoqualmie_west.resort_link = "http://www.summitatsnoqualmie.com/"
snoqualmie_west.save!
 
white_pass = Resort.find_or_initialize_by(id: 175)
white_pass.base_elevation = "4,500"
white_pass.summit_elevation = "6,550"
white_pass.icon = "https://lift.opensnow.com/location-logos/whitepass.png"
white_pass.image_url = "https://visitrainier.com/wp-content/uploads/2014/06/matthew-poppoff-6.jpg"
white_pass.latitude = "46.637302"
white_pass.longitude = "-121.391259"
white_pass.resort_link = "http://www.skiwhitepass.com/"
white_pass.save!
 
