class FavoritesController < ApplicationController
  def create
    @project = Project.find(params[:id])
    @project_favorite = current_influencer.favorites.create(project_id: params[:id])
    @project_favorite.save
  end

  def destroy
    @project = Project.find(params[:id])
    @project_favorite = Favorite.find_by(project_id: params[:id], influencer_id: current_influencer)
    @project_favorite.destroy
  end
end
