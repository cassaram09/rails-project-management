class TagsController < ApplicationController
  before_action :set_tag, only: [:update, :destroy]

  ## STANDARD RESTFUL ACTIONS

  def index
    @tags = @user.tags
    @tag = Tag.new
  end

   def create
    @tag = Tag.new(tag_params)
    if @user.tags.collect {|t| t.name}.include?(@tag.name)
      flash[:alert] = "You already made that tag!"
      redirect_to tags_path
    elsif 
      @tag.save
      redirect_to tags_path
    else
      @tags = @user.tags
      render :index
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path
    else
    
      @tags = @user.tags
      render :index
    end
  end

  def show
    redirect_to tags_path
  end

  def edit
    redirect_to tags_path
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  ## PRIVATE METHODS

  private
  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :user_id)
  end

end
