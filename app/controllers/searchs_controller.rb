class SearchsController < ApplicationController

  def search
    @model = params["model"]
    @content = params["content"]
    @records = search_for(@model, @content)
    @projects = Project.ransack(tags_name_cont: params[:content])
    if company_signed_in?
      render :layout => 'company'
    else
      render :layout => 'influencer'
    end
  end


  private
  def search_for(model, content)
    # if model == 'tag'
    #   Tag.where('name LIKE ?', '%'+content+'%')
    # elsif model == 'project'
    #   Project.where('title LIKE ?', '%'+content+'%')
    # end
    if params[:model] == 'project'
      @records = Project.ransack(title_cont: params[:content]).result
    elsif params[:model] == 'tag'
      @records = Project.ransack(tags_name_cont: params[:content]).result
    end
  end
end
