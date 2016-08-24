class TasksController < ApplicationController
  layout "tasks_layout"
  before_action :set_task
  before_action :set_project
  before_action :project_task_statuses_count, only: [:index, :complete, :overdue]
  before_action :all_task_statuses_count, only: [:all_active_tasks, :all_complete_tasks, :all_overdue_tasks]

  ## STANDARD RESTFUL ACTIONS

  def index
    @task = Task.new(project_id: @project.id)
    authorize @task
    @tasks = @project.active_tasks
  end

  def new
    @task = Task.new(project_id: @project.id)
    authorize @task
    @task_users = task_users
  end

  def create
    @task = Task.new(task_params)
    authorize @task
    if @task.save
      redirect_to task_path(@task)
    else
      @task_users = task_users
      render :new
    end
  end

  def show
    @project = @task.project
    @comment = Comment.new
    @comments = @task.comments.reverse
    @assigned_users = @task.assigned_users
    @tags = @task.tags
  end

  def edit
    authorize @task
    @project = @task.project
    @task_users = task_users
  end

  def update
    authorize @task
    @task.update(task_params)
    if task_params[:tag_names]
      @task.update(tag_names: task_params[:tag_names])
    end
    redirect_to task_path(@task)
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to project_tasks_path(@project)
  end

  ## ADDITIONAL ACTIONS

  # PROJECT TASKS 
  def complete
    @tasks = @project.complete_tasks
  end

  def overdue
    @tasks = @project.overdue_tasks
  end

  # ALL USER RELATED TASKS
  def all_active_tasks
    @tasks = (@user.tasks.active + @user.assigned_tasks.active).uniq
    @tasks.flatten!
  end

  def all_complete_tasks
    @tasks = (@user.tasks.complete + @user.assigned_tasks.complete).uniq
    @tasks.flatten!
  end

  def all_overdue_tasks
    @tasks = (@user.tasks.overdue + @user.assigned_tasks.overdue).uniq
    @tasks.flatten!
  end

  def quick_new_task
   @task = Task.new
   @projects = @user.active_projects + @user.collaboration_projects.active
  end

  ## PRIVATE METHODS

  private
  def set_user
    @user = current_user
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def project_task_statuses_count
    @overdue = @project.overdue_tasks.count
    @active = @project.active_tasks.count
    @complete = @project.complete_tasks.count
  end

  def all_task_statuses_count
    @overdue = (current_user.overdue_tasks + current_user.overdue_assigned_tasks).uniq.count
    @active = (current_user.active_tasks + current_user.active_assigned_tasks).uniq.count
    @complete= (current_user.complete_tasks + current_user.complete_tasks).uniq.count
  end

  def task_params
    params.require(:task).permit(:name, :description, :project_id, :owner_id, :due_date, :status, :tag_names, assigned_user_ids: [], tag_ids: [])
  end

  def task_users
    task_users = []
    task_users << @task.project.collaborators
    task_users << @user
    task_users.flatten
  end
end
