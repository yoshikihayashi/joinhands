class SearchsController < ApplicationController

  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end

  private


  def search_for(model, content, method)
    if model == 'influencer'
      if method == 'perfect'
        Influencer.where(name: content)
      else
        Influencer.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == 'project'
      if method == 'perfect'
        Project.where(title: content)
      else
        Project.where('title LIKE ?', '%'+content+'%')
      end
    end
  end



end
