class ProjectsController < ApplicationController
  before_action :set_user, except: [:destroy]
  before_action :set_project, except: [:index, :new, :create]
  layout "projects_layout", except: [:all_tasks]

  def index
    @projects = @user.active_projects
    @project = Project.new
  end

  def new

  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path
    else
      @projects = @user.projects
      @project
      render :index
    end
  end

  def show
  end

  def edit 
    redirect_to project_path(@project)
  end

  def update
    if (@project.status == "complete" && project_params[:status] == "active")
      @project.update(project_params)
      redirect_to project_path(@project)
    elsif @project.status == "complete"
      render :show
    else
      @project.update(project_params)
      redirect_to project_path(@project)
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def complete
    @projects = @user.complete_projects
  end

  def all_tasks
    @tasks = @user.all_user_tasks
  end

  private
  def set_user
    @user = current_user
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :user_id, :due_date, :status)
  end
end
