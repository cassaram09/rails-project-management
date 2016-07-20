class TasksController < ApplicationController
  before_action :set_task, except: [:index, :new, :create]
  before_action :set_project, except: [:index, :new]
  # before_action :check_user

  def index
    @task = Task.new
    @tasks = @user.all_user_tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to project_tasks_path(task_params[:project_id])
    elsif URI(request.referer).path == "/tasks/new"
      render :new
    elsif URI(request.referer).path == "/tasks"
      @tasks = @user.all_user_tasks
      render :index 
    else 
      @project = Project.find_by(id: params[:task][:project_id])
      @tasks = @project.tasks
      render 'projects/tasks'
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    @task.tags.clear
    @task.update(task_params)
    redirect_to project_tasks_path
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path
  end

  def complete
    @complete = Task.complete
  end

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

  def task_params
    params.require(:task).permit(:name, :description, :project_id, :user_id, :due_date, :status, :priority, :tag_names)
  end
end
