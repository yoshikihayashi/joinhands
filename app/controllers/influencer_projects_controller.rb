class InfluencerProjectsController < ApplicationController
  # layout 'company'

  def new
    @influencer_project = InfluencerProject.new
    @influencer = Influencer.find(params[:influencer_id])
  end

  def show
    @influencer_project = InfluencerProject.find(params[:id])
    if current_influencer && current_influencer.id == @influencer_project.influencer_id
      @influencer_project.checked = true
      @influencer_project.save
    elsif current_company && current_company.id == @influencer_project.company_id
      @influencer_project.company_checked = true
      @influencer_project.save
    end
  end

  def update
    @influencer_project = InfluencerProject.find(params[:id])
    @influencer_project.update(status: params[:influencer_project][:status].to_i)
    redirect_to influencers_path
  end

  def create
   influencer_project =  InfluencerProject.new(influencer_project_params)
   influencer_project.status = 0
   if influencer_project.save
     redirect_to  companies_path
   else
     render "new"
   end

  end

  private

  def influencer_project_params
    params.permit(:message, :influencer_id, :project_id)
  end


end
