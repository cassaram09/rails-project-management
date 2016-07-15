class TagsController < ApplicationController
  before_action :set_user
  before_action :set_tag, only: [:update, :destroy]

  def index
    @tags = @user.tags
  end

  def update
    @tag.update(name: params[:tag][:name])
    redirect_to tags_path
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  private
  def set_user
    @user = current_user
  end

  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end
end
