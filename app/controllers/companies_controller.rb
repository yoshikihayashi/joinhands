class CompaniesController < ApplicationController
  #skip_before_action :authenticate_influencer!
  before_action :set_company, only: [:show, :edit, :update]
  layout 'company'

  def index
    @influencers = Influencer.all
  end

  def show
    @projects = Project.where(company_id: current_company.id)
    @company_reviews = CompanyReview.where(company_id: @company.id)
  end

  def edit
  end

  def update
    @company.update(company_params)
    flash[:success] = 'プロフィールを更新しました！'
    redirect_to company_path(@company.id)
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:company_name, :business_detail, :employee_number, :representative_name, :phone_number)
  end
end
