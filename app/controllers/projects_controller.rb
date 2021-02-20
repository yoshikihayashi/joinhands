class ProjectsController < ApplicationController
  layout 'company'

  def new
    @project = Project.new
  end

  def create
    tag_list = project_params[:tag_ids]
    project_params_hash = project_params.to_h
     project_params_hash.delete(:tag_ids)
    @project = current_company.projects.build(project_params_hash)
    if @project.save
      @project.save_tags(tag_list)
       flash[:success] = '投稿しました!'
       redirect_to projects_path
    else
       render 'new'
    end
  end

  def index
    @projects = Project.all
    @project_favorite = Favorite.new

  end

  def show
     @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:image, :title, :details, :price, :tag_ids)
  end

end
