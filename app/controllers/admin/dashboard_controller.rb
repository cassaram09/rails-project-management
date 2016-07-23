class Admin::DashboardController < ApplicationController
  layout "admin_layout"
  before_action :authenticate_user

  def index
    @projects = Project.all
    @users = User.all 
    @comments = Comment.all 
    @notes = Note.all 
    @tasks = Task.all 
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