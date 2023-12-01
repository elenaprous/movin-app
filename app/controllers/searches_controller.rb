class SearchesController < ApplicationController
  def show
    @search = Search.find(params[:id])

    # scores = [@search.supermarkets_score, @search.schools_score, @search.parks_score, @search.nightlife_score, @search.restaurants_score, @search.transportation_score]
    @markers = [
      # scores.geocoded.map do |score|
      #   {
      #     lat: score.latitude,
      #     lng: score.longitude,
      #     info_window_html: render_to_string(partial: "info_window", locals: { score: score })
      #   }
      # end,
      {
        lat: @search.location.latitude,
        lng: @search.location.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { location: location })
      }
    ]
  end

  def index
    @searches = current_user.searches
  end
end
