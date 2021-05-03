class City < ApplicationRecord
  validates_uniqueness_of :name, scope: :country
  validates :latitude , numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  EARTH_RADIUS = 6371.0

  attr_accessor :distance

  def self.closest_to(latitude:, longitude:, radius: 1000)
    return [] if [latitude, longitude, radius].any?(&:blank?)
    radius = radius.to_f
    City.all.map do |city|
      lat1 = deg_to_rad(latitude.to_f)
      lat2 = deg_to_rad(city.latitude)
      long1 = deg_to_rad(longitude.to_f)
      long2 = deg_to_rad(city.longitude)
      delta = Math.acos(Math.sin(lat1)*Math.sin(lat2) + Math.cos(lat1)*Math.cos(lat2)*Math.cos((long1-long2).abs))
      city.distance = EARTH_RADIUS * delta
      city
    end.select do |city|
      city.distance <= radius
    end.sort_by(&:distance)
  end

  def self.seed
    cities = JSON.parse(Rails.root.join("db/europe.json").read)
    cities.each do |city_attributes|
      name, country = city_attributes["properties"].values_at("capital", "country")
      # attention a ne pas inverser
      long, lat = city_attributes.dig("geometry", "coordinates")
      city = City.find_or_initialize_by(name: name, country: country)
      city.update! latitude: lat, longitude: long
    end
  end

  def self.deg_to_rad(number)
    number * Math::PI / 180.0
  end
end
