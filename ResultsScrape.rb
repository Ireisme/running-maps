class ResultsScrape
    def self.scrape(url)
        route_ids = []
        data = Nokogiri::HTML(open(url))
        results = data.css('.routeResultTile a.thumbnailUrl')
        results.each do |result|
            link = result.attribute('href')
            puts link
            route_ids << link
        end
        
        return route_ids
    end
end