require 'nokogiri'
require 'open-uri'
require 'json'
require 'colored'
require 'certified'

require_relative 'ResultsScrape'
require_relative 'RoutesScrape'
require_relative 'GpxGenerator'

paths = []
gpx = <<EOD
  <?xml version="1.0" encoding="UTF-8"?>
  <gpx
    version="1.1"
    creator="RunKeeper - http://www.runkeeper.com"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://www.topografix.com/GPX/1/1"
    xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd"
    xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1">
EOD

# change to how far back in pagination we should scrape
# some cities don't go too far back
(1..37).each do |page|
    url = "https://runkeeper.com/search/routes/#{page}?distance=&lon=-78.899&location=durham%2C+nc&activityType=RUN&lat=35.994"
    #url = "http://runkeeper.com/search/routes/#{page}?distance=&lon=-79.056&location=chapel+hill%2C+nc&activityType=RUN&lat=35.913"
    #url = "http://runkeeper.com/search/routes/#{page}?distance=&lon=-78.638&location=raleigh%2C+nc&activityType=RUN&lat=35.78"
    
    puts "#{page}. #{url}".green
    paths.concat ResultsScrape.scrape(url)

    sleep [1.1,2.2,3.3].sample
end

routes = RoutesScrape.scrape(paths)
GpxGenerator.generate(routes, gpx)