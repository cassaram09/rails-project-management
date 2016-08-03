class ProjectsController < ApplicationController
  layout "projects_layout"
  before_action :set_project, except: [:create]
  before_action :project_statuses_count, only: [:index, :complete, :overdue]

  ## STANDARD RESTFUL ACTIONS

  def index
    @projects = (@user.active_projects + @user.collaboration_projects.active).reverse
  end

  def new
    @project = Project.new
    @project.notes.build
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      @project
      render :new
    end
  end

  def show
    authorize @project
    @project = Project.find_by(id: params[:id])
    @user_projects = UserProject.projects(@project.id)
  end

  def edit 
    authorize @project
    @project = Project.find_by(id: params[:id])
    @collaborators = @project.collaborators
    @user_projects = UserProject.projects(@project.id)
  end

  def update
    authorize @project
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :show
    end
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to projects_path
  end

  ## ADDITIONAL ACTIONS
  
  def delete_collaborator
    authorize @project
    user = User.find_by(id: params[:user][:id])
    @project.collaborators.delete(user)
    @project.save
    redirect_to project_path(@project)
  end

  def complete_tasks
    @tasks = @project.tasks.complete
  end

  def complete
    @projects = (@user.complete_projects + @user.collaboration_projects.complete).reverse
  end

  def overdue
    @projects = (@user.projects.overdue + @user.collaboration_projects.overdue).reverse
  end

  ## PRIVATE METHODS

  private
  def set_project
    if params[:id]
       @project = Project.find_by(id: params[:id])
    else
      @project = Project.find_by(id: params[:project_id])
    end
  end

  def project_statuses_count
    @overdue = (current_user.overdue_projects + current_user.collaboration_projects.overdue).uniq.count
    @active = (current_user.active_projects + current_user.collaboration_projects.active).uniq.count
    @complete = (current_user.complete_projects + current_user.collaboration_projects.complete).uniq.count
  end

  def project_params
    params.require(:project).permit(:name, :description, :collaborator_emails, :owner_id, :due_date, :status, notes_attributes: [:title, :content, :user_id])
  end
end
