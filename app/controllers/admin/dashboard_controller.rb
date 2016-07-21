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

  def search
    if params[:search].blank?
      redirect_to(request.referrer)
    end
    @projects = Project.search(params[:search]).order("created_at DESC")
    #@tags = Tag.search(params[:search]).order("created_at DESC")
    @comments = Comment.search(params[:search]).order("created_at DESC")
    # @tasks = Task.search(params[:search]).order("created_at DESC")
    @notes = Note.search(params[:search]).order("created_at DESC")
    @tasks1 = Task.search_by_tags(params[:search])
    @tasks2 = Task.search(params[:search]).order("created_at DESC")
  end

  private

  def authenticate_user
    unless @user.admin?
      redirect_to root_path
    end
  end

end