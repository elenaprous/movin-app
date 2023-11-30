class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  CACHE = ActiveSupport::Cache::MemoryStore.new

  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :important_addresses,
      :supermarkets_score, :schools_score, :parks_score, :nightlife_score, :restaurants_score, :transportation_score, :gyms_score])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :important_addresses,
      :supermarkets_score, :schools_score, :parks_score, :nightlife_score, :restaurants_score, :transportation_score, :gyms_score])
  end
end
