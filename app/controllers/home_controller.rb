class HomeController < ApplicationController
  layout "home_layout"
  
  def index
  end
  
  def search
    if params[:search].blank?
      redirect_to(request.referrer)
    end
    @projects = Project.search(params[:search], current_user.id).order("created_at DESC")
    #@tags = Tag.search(params[:search]).order("created_at DESC")
    @comments = Comment.search(params[:search], current_user.id).order("created_at DESC")
    # @tasks = Task.search(params[:search]).order("created_at DESC")
    @notes = Note.search(params[:search], current_user.id).order("created_at DESC")
    @tasks1 = Task.search_by_tags(params[:search], current_user.id)
    @tasks2 = Task.search(params[:search], current_user.id).order("created_at DESC")
  end

end
