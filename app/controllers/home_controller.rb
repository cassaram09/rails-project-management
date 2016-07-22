class HomeController < ApplicationController
  layout "home_layout"
  
  def index
  end
  
  def search
    if params[:search].blank?
      redirect_to(request.referrer)
    end
    @projects = Project.keyword_search(params[:search], current_user)
    @comments = Comment.keyword_search(params[:search], current_user)
    @notes = Note.keyword_search(params[:search], current_user)
    @tasks1 = Task.search_by_tags(params[:search], current_user)
    @tasks2 = Task.keyword_search(params[:search], current_user)
  end

end
