class TaskPolicy < ApplicationPolicy
  def new?
    return true if project_owner?
    up = find_user_project
    user.admin? || (up.collaborator_id == user.id && up.permission == "edit")
  end

  def create?
    return true if project_owner?
    up = find_user_project
    user.admin? || (up.collaborator_id == user.id && up.permission == "edit")
  end
  
  def show?
    return true if project_owner?
    up = find_user_project
    user.admin? || record.user == user || !up.nil?
  end

  def edit?
    return true if project_owner?
    up = find_user_project
    user.admin? || record.user == user || (up.collaborator_id == user.id && up.permission == "edit") 
  end

  def update?
    return true if project_owner?
    up = find_user_project
    user.admin? || record.user == user || (up.collaborator_id == user.id && up.permission == "edit") 
  end

  def destroy?
    return true if project_owner?
    user.admin? || record.user == user
  end
end