class SearchesController < ApplicationController
  def show
    @search = Search.find(params[:id])
  end
end
