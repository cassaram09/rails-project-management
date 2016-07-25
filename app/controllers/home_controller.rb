class HomeController < ApplicationController
  layout "home_layout"

  def index
    if current_user
      @projects = (current_user.projects + current_user.collaboration_projects).uniq.count
      @overdue_projects = current_user.overdue_projects.count + current_user.collaboration_projects.active.count
      @active_projects = current_user.active_projects.count + current_user.collaboration_projects.active.count
      @complete_projects = current_user.complete_projects.count + current_user.collaboration_projects.active.count
      @overdue_tasks = current_user.overdue_tasks.count
      @active_tasks = current_user.active_tasks.count
      @complete_tasks = current_user.complete_tasks.count
      @overdue_assigned_tasks = current_user.overdue_assigned_tasks.count
      @active_assigned_tasks = current_user.active_assigned_tasks.count
      @complete_assigned_tasks = current_user.complete_assigned_tasks.count
    end
  end

end
