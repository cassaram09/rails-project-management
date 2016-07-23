class UserProjectsController < ApplicationController
  def edit_user_project_permission
    up = UserProject.find_by(id: user_project_params[:id])
    up.permission = user_project_params[:permission]
    up.save
    redirect_to edit_project_path(user_project_params[:project_id])
  end

  private
  def user_project_params
    params.require(:user_project).permit(:id, :permission, :project_id)
  end
end
