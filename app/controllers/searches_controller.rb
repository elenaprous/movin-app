class SearchesController < ApplicationController
  def show
    @search = Search.find(params[:id])

    @markers = [{
      lat: @search.location.latitude,
      lng: @search.location.longitude
    }]
  end
end
