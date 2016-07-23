class CommentsController < ApplicationController
  layout "comments_layout", only: [:index]
  layout "tasks_layout"
  
  before_action :set_project
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    binding.pry
    @comments = @project.comments
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to task_path(@comment.task)
    else
      @task = @comment.task
      @comments = @task.comments
      render 'tasks/show'
    end
  end

  def edit
    @task = @comment.task
  end

  def update
    @comment.update(comment_params)
    redirect_to task_path(@comment.task)
  end

  def destroy
    @comment.destroy
    redirect_to task_path(@comment.task)
  end

  private
  def set_user
    @user = current_user
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def find_task
    Task.find_by(id: @comment.task_id)
  end

  def find_project
    Project.find_by(id: find_task.project_id)
  end

  def set_project
    if params[:id]
       @project = Project.find_by(id: params[:id])
    else
      @project = Project.find_by(id: params[:project_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :task_id, :user_id)
  end
end
