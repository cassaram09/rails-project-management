class TasksController < ApplicationController
  before_action :set_user, except: [:destroy]
  before_action :set_task, except: [:index, :new, :create]
  before_action :set_project

  def index
    if !@user.project_ids.include?(params[:project_id].to_i)
      redirect_to projects_path
    else
      @tasks = @project.tasks
      @task = Task.new
    end
  end

  def new
    redirect_to project_tasks_path
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to project_tasks_path
    else
      @tasks = @user.tasks
      @task
      render :index
    end
  end

  def show
    authorize @task
    @comment = Comment.new
  end

  def edit
    redirect_to project_task_path(@project, @task)
  end

  def update
    authorize @task
    @task.tags.clear
    @task.update(task_params)
    redirect_to project_tasks_path
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to project_tasks_path
  end

  def complete
    authorize @task
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
