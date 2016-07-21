class Admin::DashboardController < ApplicationController
  # Controller for users with role: admin
  before_action :authenticate_user!

  def index
    @projects = Project.all
    @users = User.all 
    @comments = Comment.all 
    @notes = Note.all 
    @tasks = Task.all 
    @tags = Tag.all
  end

  def tags
    @tags = Tag.all
  end

  def users
    @users = User.all
  end

  private

  def authenticate_user
    unless @user.admin?
      redirect_to root_path
    end
  end

end