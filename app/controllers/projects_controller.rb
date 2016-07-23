class ProjectsController < ApplicationController
  layout "projects_layout"
  before_action :set_project, except: [:create]
  before_action :project_statuses_count, only: [:index, :complete, :overdue]
  
  #before_action :check_user, except: [:index, :create, :complete, :tasks, :new, :complete_tasks]

  def index
    @projects = @user.active_projects + @user.collaboration_projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.find_by(id: params[:id])
  end

  def edit 
    @project = Project.find_by(id: params[:id])
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :show
    end
  end

  def delete_collaborator
    user = User.find_by(id: params[:user][:id])
    @project.collaborators.delete(user)
    @project.save
    redirect_to project_path(@project)
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def tasks
    @task = Task.new
    @tasks = @project.tasks
  end

  def complete_tasks
    @tasks = @project.tasks.complete
  end

  def complete
    @projects = @user.complete_projects.reverse
  end

  def overdue
    @projects = @user.projects.overdue + @user.collaboration_projects.overdue
  end

  private

  def check_user
    unless @user.project_ids.include?(params[:id].to_i) || @user.admin?
      flash[:alert] = "You are not cleared to perform that action."
      redirect_to projects_path
    end
  end

  def set_project
    if params[:id]
       @project = Project.find_by(id: params[:id])
    else
      @project = Project.find_by(id: params[:project_id])
    end
  end

  def project_statuses_count
    @overdue = current_user.overdue_projects.count
    @active = current_user.active_projects.count
    @complete = current_user.complete_projects.count
  end

  def project_params
    params.require(:project).permit(:name, :description, :collaborator_emails, :owner_id, :due_date, :status)
  end
end
