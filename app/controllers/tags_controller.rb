class TagsController < ApplicationController
  before_action :set_tag, only: [:update, :destroy]

  ## STANDARD RESTFUL ACTIONS

  def index
    @tags = (@user.tags + @user.collaboration_tags).flatten
    @tags.uniq!
    @tag = Tag.new
  end

   def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      @tags = (@user.tags + @user.collaboration_tags).flatten
      render :index
    end
  end

  def update
    if @tag.user == @user && @tag.update(tag_params)
      redirect_to tags_path
    else
      @tags = (@user.tags + @user.collaboration_tags).flatten
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
    if @tag.user == @user
      redirect_to tags_path
      @tag.destroy
    else
      redirect_to tags_path
    end
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
