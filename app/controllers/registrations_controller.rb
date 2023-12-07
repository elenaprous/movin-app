class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.important_addresses = [params[:user][:important_addresses]] if params[:user][:important_addresses]

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        if session[:location_id]
          @search = Search.create!(user_id: resource.id, location_id: session[:location_id])
          @search.compute_score_and_rank
          redirect_to search_path(@search)
        else
          respond_with resource, location: after_sign_up_path_for(resource)
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      if params[:user][:important_addresses]
        redirect_to new_user_registration_path(important_addresses: params[:user][:important_addresses], supermarkets_score: params[:supermarkets_score], ), alert: resource.errors.full_messages.join(', ')
      else
        respond_with resource
      end
    end
  end
end
