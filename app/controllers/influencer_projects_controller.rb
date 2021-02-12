class InfluencerProjectsController < ApplicationController
  layout 'company'

  def new
    @influencer_project = InfluencerProject.new
   @influencer = Influencer.find(params[:influencer_id])

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
