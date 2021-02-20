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
    # tag_list = influencer_params[:tag_ids]
    # influencer_params_hash = influencer_params.to_h
    # influencer_params_hash.delete(:tag_ids)
    # @influencer = current_influencer.build(influencer_params_hash)
    if @influencer.update(influencer_params)
      # @influencer.save_tags(tag_list)
      # flash[:success] = '投稿しました!'
      redirect_to influencer_path(@influencer.id)
    else
      render 'edit'
    end
    # @influencer.update(influencer_params)
    # redirect_to influencer_path(@influencer.id)
  end

   private

  def influencer_params
    params.require(:influencer).permit(:nickname, :image, :details,:name_kana,:address, :tag_ids)
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
