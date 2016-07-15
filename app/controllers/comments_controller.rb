class CommentsController < ApplicationController
  before_action :set_user
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
  end
  def create
    @comment = Comment.create(comment_params)
    redirect_to project_task_path(find_project, find_task)
  end

  def edit
    @task = @comment.task
  end

  def update
    @comment.update(comment_params)
    redirect_to project_task_path(find_project, find_task)
  end

  def destroy
    @comment.destroy
    redirect_to project_task_path(find_project, find_task)
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

  def comment_params
    params.require(:comment).permit(:description, :task_id, :user_id)
  end
end
