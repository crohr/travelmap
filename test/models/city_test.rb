require "test_helper"

class CityTest < ActiveSupport::TestCase
  test "it is invalid if no latitude or longitude given" do
    city = City.new(name: "city", country: "country", latitude: 45.5, longitude: 13.4)
    assert city.valid?
    city.latitude = nil
    refute city.valid?
  end

  test ".closest_to" do
    City.seed
    cities = City.closest_to(latitude: 48.0833, longitude: -1.6833, radius: 600)
    assert_equal 6, cities.size
    paris = cities.find{|c| c.name == "Paris"}
    assert_not_nil paris
    assert_equal 309, paris.distance.floor
  end
end
