# frozen_string_literal: true

class Companies::SessionsController < Devise::SessionsController
  layout 'company'
  # before_action :configure_sign_in_params, only: [:create]

  def new_guest
    company = Company.guest
    sign_in company
    flash[:success] = 'ゲストユーザーとしてログインしました！'
    redirect_to company_path(current_company.id)
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
