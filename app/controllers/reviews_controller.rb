class ReviewsController < ApplicationController
  
  def new
    @project = Project.find(params[:id])
    @influencer = Influencer.find(params[:influencer_id])
    @review =Review.new
    if company_signed_in?
      render :layout => 'company'
    else
      render :layout => 'influencer'
    end
  end

  def create
    project = Project.find(params[:id])
    influencer = Influencer.find(params[:influencer_id])
    review = Review.new(review_params)
    review.rate = params[:review][:rate].to_i
    review.influencer_id = influencer.id
    review.project_id = project.id
    review.save!
    InfluencerProject.find_by(project_id: project.id, influencer_id: influencer.id).update!(status: 3)
    redirect_to project
  end

   private

  def review_params
    params.permit(:rate)
  end







end