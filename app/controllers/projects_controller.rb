class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]
  #layout "projects_layout"
  before_action :check_user, except: [:index, :create, :complete, :tasks]


  def index
    binding.pry
    @projects = @user.active_projects.reverse
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
    binding.pry
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

  def tasks
    @tasks = @project.tasks
  end

  def complete
    @projects = @user.complete_projects.reverse
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

  def project_params
    params.require(:project).permit(:name, :description, :user_id, :due_date, :status)
  end
end
