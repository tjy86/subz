class HomeController < ApplicationController
  def index
  end
  def populate

    Subway.delete_all
    x = HTTParty.get('http://data.cityofnewyork.us/api/views/drex-xx56/rows.json')
    y = JSON(x.body)
    z = y["data"]
    binding.pry

    z.each do |entry|
      lat = entry[9][1].to_f
      long = entry[9][2].to_f
      name = entry[10]
      line = entry[12]
      Subway.create( :lat => lat, :long => long, :name => name, :line => line)
    end

    redirect_to entrances_path
  end
  def entrances
    @sub = Subway.all
  end
end
