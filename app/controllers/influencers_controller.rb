class InfluencersController < ApplicationController
  layout 'influencer'

  def index
    @projects = Project.all
  end

  def show
    @influencer = Influencer.find(params[:id])
  end

  def edit
    @influencer = Influencer.find(params[:id])
  end

  def update
    @influencer = Influencer.find(params[:id])
    @influencer.update(influencer_params)
    redirect_to influencer_path(@influencer.id)
  end

   private

  def influencer_params
    params.require(:influencer).permit(:nickname, :image, :details)
  end

  # private
  # def influencer_params
  #   params.require(:influencer).permit(
  #     :nickname,
  #     :image,
  #     :details,
  #   )
  # end

end
