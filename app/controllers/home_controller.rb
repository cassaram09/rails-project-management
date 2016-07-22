class HomeController < ApplicationController
  layout "home_layout"
  
  def index
    @overdue = current_user.overdue_projects.count
    @active = current_user.active_projects.count
    @complete = current_user.complete_projects.count
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
