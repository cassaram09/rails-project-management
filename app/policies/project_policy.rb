class ProjectPolicy < ApplicationPolicy

  def show?
    up = find_user_project
    user.admin? || record.owner == user || !up.nil?
  end

  def edit?
    up = find_user_project
   user.admin? || record.owner == user || (up.collaborator_id == user.id && up.permission == "edit")
  end

  def update?
    up = find_user_project
    user.admin? || record.owner == user || (up.collaborator_id == user.id && up.permission == "edit")
  end

  def destroy?
    user.admin? || record.owner == user
  end

end