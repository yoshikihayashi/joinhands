class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Company
      flash[:success] = 'ログインしました！'
      company_path(current_company.id)
    when Influencer
      flash[:success] = 'ログインしました！'
      influencers_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :company_name, :email, :name_kana, :follower_count, :address, :nickname, :representative_name, :phone_number, :business_detail, :employee_number])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :company_name, :email, :name_kana, :follower_count, :address, :nickname, :representative_name, :phone_number, :business_detail, :employee_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :company_name, :email, :name_kana, :follower_count, :address, :nickname, :representative_name, :phone_number, :business_detail, :employee_number])
  end
end
