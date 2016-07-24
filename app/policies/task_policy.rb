class TaskPolicy < ApplicationPolicy
  def new?
    project_owner?
    up = find_user_project
    user.admin? || (up.collaborator_id == user.id && up.permission == "edit")
  end

  def create?
    project_owner?
    up = find_user_project
    user.admin? || (up.collaborator_id == user.id && up.permission == "edit")
  end
  
  def show?
    project_owner?
    up = find_user_project
    user.admin? || record.user == user || !up.nil?
  end

  def edit?
    project_owner?
    up = find_user_project
    user.admin? || record.user == user || (up.collaborator_id == user.id && up.permission == "edit") 
  end

  def update?
    project_owner?
    up = find_user_project
    user.admin? || record.user == user || (up.collaborator_id == user.id && up.permission == "edit") 
  end

  def destroy?
    project_owner?
    user.admin? || record.user == user
  end
end