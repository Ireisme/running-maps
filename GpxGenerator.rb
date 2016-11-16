require 'open-uri'
require 'json'
require 'pp'

class GpxGenerator
    def self.generate(routes, gpx)
        routes.each_with_index do |route, index|
            if route == nil
                puts index
                next
            end

            route = JSON.parse(route)
            route_gpx = ""
            route_gpx << "<trk>\n"
            route_gpx << "<name>#{index}</name>"
            route_gpx << "<time>#{DateTime.now}</time>"
            route_gpx << "<trkseg>\n"

            route.each do |point|
                route_gpx << "<trkpt lat=\"#{point['latitude']}\" lon=\"#{point['longitude']}\"></trkpt>\n"
            end

            route_gpx << "</trkseg>\n"
            route_gpx << "</trk>\n"

            gpx << route_gpx
        end

        gpx << "</gpx>"

        File.open("results/durham.gpx","w") do |f|
            f.write(gpx)
        end
    end
end