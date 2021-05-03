require "application_system_test_case"

class SearchClosestCitiesTest < ApplicationSystemTestCase
  test "visiting the index" do
    City.seed
    visit '/'
    assert_selector "h2", text: "Search cities closest to you"

    fill_in "Latitude", with: "48.08"
    fill_in "Longitude", with: "1.68"
    fill_in "Radius", with: "600"
    click_on "Search"

    assert_selector "td", text: "Paris"
  end
end
