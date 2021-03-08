class Influencers::OmniauthCallbacksController < ApplicationController
  def facebook
    callback_for(:facebook)
  end

  def twitter
    callback_for(:twitter)
  end

  def google_oauth2
    callback_for(:google)
  end

  # common callback method
  def callback_for(provider)
    @influencer = Influencer.from_omniauth(request.env["omniauth.auth"])
    if @influencer.persisted?
      sign_in_and_redirect @influencer, event: :authentication # this will throw if @influencer is not activated
      # set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_influencer_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
