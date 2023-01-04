# frozen_string_literal: true

class Managers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    super
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone gender])
  end
end
