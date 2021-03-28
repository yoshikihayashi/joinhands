class ProjectsController < ApplicationController
  before_action :authenticate_company!, only: [:new, :create, :destroy]
  layout 'company'

  def new
    @project = Project.new
  end

  def create
    @project = current_company.projects.build(project_params)
    tag_list = params[:project][:tag_ids].split(",")
    project_params_hash = project_params.to_h
    project_params_hash.delete(:tag_ids)
    if @project.save
      @project.save_tags(tag_list)
      flash[:success] = '投稿しました!'
      redirect_to projects_path
    else
      flash[:success] = '投稿に失敗しました。。'
      render 'new'
    end
  end

  def index
    @projects = Project.all
    @project_favorite = Favorite.new
  end

  def show
    @project = Project.find(params[:id])
    @influencers = Influencer.includes(:influencer_projects).where(influencer_projects: { status: 2, project_id: @project })
    @influencer_projects = InfluencerProject.where(project_id: params[:id])
    @completion_influencers = Influencer.includes(:influencer_projects).where(influencer_projects: { status: 3, project_id: @project })
    if company_signed_in?
      render :layout => 'company'
    else
      render :layout => 'influencer'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:success] = '投稿を削除しました!'
    redirect_to projects_path
  end

  def edit
    @project = Project.find(params[:id])
    @tag_list =@project.tags.pluck(:name).join(",")
  end

  def update
    @project = Project.find(params[:id])
    tag_list = params[:project][:tag_ids].split(',')
    if @project.update_attributes(project_params)
      @project.save_tags(tag_list)
      flash[:success] = '編集完了です！'
      redirect_to project_path(@project.id)
    else
      flash[:success] = '編集失敗です。。'
      render 'edit'
    end
  end

  private

  def project_params
    params.require(:project).permit(:image, :title, :details, :price)
  end
end
