class CompanyReviewsController < ApplicationController

  def new
    @project = Project.find(params[:id])
    @company = Company.find(params[:company_id])
    @company_review = CompanyReview.new
    if company_signed_in?
      render :layout => 'company'
    else
      render :layout => 'influencer'
    end
  end

  def create
    project = Project.find(params[:id])
    company = Company.find(params[:company_id])
    company_review = CompanyReview.new(company_review_params)
    company_review.rate = params[:company_review][:rate].to_i
    company_review.company_id = company.id
    company_review.project_id = project.id
    company_review.save!
    InfluencerProject.find_by(project_id: project.id, company_id: company.id).update!(status: 4)
    redirect_to influencer_projects
  end

   private

  def company_review_params
    params.permit(:rate,:comment)
  end

end
