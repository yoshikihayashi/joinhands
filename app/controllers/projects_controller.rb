class ProjectsController < ApplicationController
  layout 'company'

  def new
    @project = Project.new
  end

  def create
    tag_list = project_params[:tag_ids].split(",")
    project_params_hash = project_params.to_h
     project_params_hash.delete(:tag_ids)
    @project = current_company.projects.build(project_params_hash)
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
    @influencers = Influencer.includes(:influencer_projects).where(influencer_projects: {status: 2, project_id: @project})
     @influencer_projects = InfluencerProject.where(project_id: params[:id])
     @completion_influencers =  Influencer.includes(:influencer_projects).where(influencer_projects: {status: 3, project_id: @project})
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

  private

  def project_params
    params.require(:project).permit(:image, :title, :details, :price, :tag_ids)
  end

end
