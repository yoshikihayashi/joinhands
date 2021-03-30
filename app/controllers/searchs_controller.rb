class SearchsController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @records = search_for(@model, @content)
    @projects = Project.search_by_tag(params[:content])
    if company_signed_in?
      render :layout => 'company'
    else
      render :layout => 'influencer'
    end
  end

  private

  def search_for(model, content)
    if params[:model] == 'project'
      @records = Project.ransack(title_cont: params[:content]).result
    elsif params[:model] == 'tag'
      @records = Project.ransack(tags_name_cont: params[:content]).result
    elsif params[:model] == 'influencer'
      @records = Influencer.ransack(nickname_cont: params[:content]).result
    end
  end
end
