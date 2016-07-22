class TasksController < ApplicationController
  layout "tasks_layout"
  before_action :set_task
  before_action :set_project, except: [:update, :destroy]
  before_action :project_task_statuses_count, only: [:index, :complete, :overdue]
  # before_action :check_user

  ## STANDARD RESTFUL ROUTES

  def index
    @task = Task.new
    @tasks = @project.active_tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task)
    # elsif URI(request.referer).path == "/tasks/new"
    #   render :new
    # elsif URI(request.referer).path == "/tasks"
    #   @tasks = @user.tasks
    #   render :index 
    else 
    #   @project = Project.find_by(id: params[:task][:project_id])
    #   @tasks = @project.tasks
      render :new
    end
  end

  def show
    @project = @task.project
    @comment = Comment.new
    @comments = @task.comments.reverse.each
  end

  def edit
  end

  def update
    @task.tags.clear
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path
  end

  ## ADDITIONAL ROUTES

  def complete
    @tasks = @project.complete_tasks
  end

  def overdue
    @tasks = @project.overdue_tasks
  end

  def all_tasks
    @tasks = @user.tasks
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

  # def check_user
  #   if !@user.project_ids.include?(params[:project_id].to_i)
  #     flash[:alert] = "You are not authorized to perform that action."
  #     redirect_to projects_path
  #   end
  # end

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

  def task_params
    params.require(:task).permit(:name, :description, :project_id, :user_id, :due_date, :status, :priority, :tag_names)
  end
end
