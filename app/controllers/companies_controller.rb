class CompaniesController < ApplicationController
  layout 'company'
  # before_action :authenticate_user!

  def index
    @influencers = Influencer.all
  end

  def show
    @company = Company.find(params[:id])
    @projects = Project.where(company_id: current_company.id)

    @company_reviews = CompanyReview.where(company_id: @company.id)
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    @company.update(company_params)
    flash[:success] = 'プロフィールを更新しました！'
    redirect_to company_path(@company.id)
  end

  private

  def company_params
    params.require(:company).permit(:company_name, :business_detail, :employee_number, :representative_name)
  end
end
