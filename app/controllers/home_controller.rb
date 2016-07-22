class HomeController < ApplicationController
  layout "home_layout"

  def index
    if current_user
      @overdue_projects = current_user.overdue_projects.count
      @active_projects = current_user.active_projects.count
      @complete_projects = current_user.complete_projects.count
      @overdue_tasks = current_user.overdue_tasks.count
      @active_tasks = current_user.active_tasks.count
      @complete_tasks = current_user.complete_tasks.count
    end
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
