class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :important_address,
      :supermarkets_i, :schools_i, :parks_i, :nightlife_i, :restaurants_i, :transportation_i, :gyms_i])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :important_address,
      :supermarkets_i, :schools_i, :parks_i, :nightlife_i, :restaurants_i, :transportation_i, :gyms_i])
  end
end
