class TagsController < ApplicationController
  before_action :set_tag, only: [:update, :destroy]

  def index
    @tags = @user.tags
    @tag = Tag.new
  end

  def create

  end

  def update
    if @tag.update(name: params[:tag][:name])
      redirect_to tags_path
    else
      binding.pry
      @tags = @user.tags
      @tag
      render :index
    end
  end

  def show
    redirect_to tags_path
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  private

  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end

end
