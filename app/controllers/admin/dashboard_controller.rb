class Admin::DashboardController < ApplicationController
  # Controller for users with role: admin
  
  before_action :set_user
  before_action :authenticate_user!

  def index
    unless @user.admin?
      redirect_to root_path
    end
    @projects = Project.all
    @users = User.all 
    @comments = Comment.all 
    @notes = Note.all 
    @tasks = Task.all 
    @tags = Tag.all
  end

  private
  def set_user
    @user = current_user
  end
end