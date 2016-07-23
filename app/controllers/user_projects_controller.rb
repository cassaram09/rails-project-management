class UserProjectsController < ApplicationController
  def edit_user_project_permission
    up = UserProject.find_by(id: params[:user_project][:id])
    binding.pry
    up.permission = params[:user_project][:permission]
    binding.pry
    up.save
    redirect_to edit_project_path(params[:user_project][:project_id])
  end
end
