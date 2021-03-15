class HomesController < ApplicationController
  skip_before_action :authenticate_influencer!
  skip_before_action :authenticate_company!

  def top
  end

  def company_info
    render :layout => 'company'
  end

  def influencer_info
    render :layout => 'influencer'
  end
end
