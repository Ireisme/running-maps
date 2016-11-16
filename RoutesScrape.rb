class  RoutesScrape
    def self.scrape(paths)
        routes = []
        paths.each_with_index do |path, index|
            url = "https://runkeeper.com#{path}"

            puts "#{index}. #{url}".blue

            current = ""

            data = Nokogiri::HTML(open(url))

            # this finds the embedded JSON for the route
            data.css('script').each do |script|
                result = script.text.match(/var\s+routePoints\s+=\s+(.*?);/m).to_s
                current = result unless result.length == 0
            end

            route = current[/\[.*?\]/]
            routes << route

            sleep [1.1,2.2,3.3,4.4,5.5,6.6].sample
        end

        return routes
    end
end
