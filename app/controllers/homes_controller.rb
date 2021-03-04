class HomesController < ApplicationController
  def top
  end

  def company_info
    render :layout => 'company'
  end

  def influencer_info
    render :layout => 'influencer'
  end
end
