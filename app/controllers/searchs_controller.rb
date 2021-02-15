class SearchsController < ApplicationController
  layout 'company'

  def search
    @model = params["model"]
    @content = params["content"]
    @records = search_for(@model, @content)
  end

  private


  def search_for(model, content)
    if model == 'influencer'
      Influencer.where('nickname LIKE ?', '%'+content+'%')
    elsif model == 'project'
      Project.where('title LIKE ?', '%'+content+'%')
    end
  end



end
