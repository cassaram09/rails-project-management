class TasksController < ApplicationController
  before_action :set_user, except: [:destroy]
  before_action :set_task, except: [:index, :new, :create]
  before_action :set_project

  def index

    @tasks = @user.tasks
    @task = Task.new
  end

  def new
    redirect_to project_tasks_path
  end

  def create
    @task = Task.create(task_params)
    redirect_to project_tasks_path
  end

  def show
    @comment = Comment.new
  end

  def edit
    redirect_to project_task_path(@project, @task)
  end

  def update
    binding.pry
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
