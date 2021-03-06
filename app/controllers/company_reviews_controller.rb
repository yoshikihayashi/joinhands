class CompanyReviewsController < ApplicationController
  layout 'influencer'
  def new
    @company_review = CompanyReview.new
    @influencer = InfluencerProject.find(params[:id])
    # byebug
    if influencer_signed_in?
      render :layout => 'influencer'
    else
      render :layout => 'company'
    end
  end

  def create
    influencer_project = InfluencerProject.find(params[:id])
    company_id = Project.find(influencer_project.project_id).company_id
    @company_review = CompanyReview.new(company_review_params)
    @company_review.company_id = company_id
    if @company_review.save
      influencer_project.update(status: 4)
      flash[:success] = '送信しました！'
      redirect_to influencer_projects_path(current_influencer.id)
    else
      flash[:success] = '送信失敗しました。。。'
      render 'new'
    end
  end

  private

  def company_review_params
    params.require(:company_review).permit(:rate, :comment, :company_id)
  end
end
