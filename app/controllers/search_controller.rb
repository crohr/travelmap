# Could also be named CitiesController
class SearchController < ApplicationController
  def index
  end

  def search
    @cities = City.closest_to(search_params)
  end

  private def search_params
    params.permit(:latitude, :longitude, :radius).to_hash.symbolize_keys
  end
end
