class NotePolicy < ApplicationPolicy
  def new?
    admin_owner_check || collaborator_permission_check
  end

  def create?
    admin_owner_check || collaborator_permission_check
  end

  def show?
    admin_owner_check || !find_user_project.nil?
  end

  def edit?
    admin_owner_check
  end

  def update?
    admin_owner_check
  end

  def destroy?
    admin_owner_check
  end

  private
  def admin_owner_check
    user.admin? || project_owner? || record_owner?
  end

  def collaborator_permission_check
    up = find_user_project
    (up.collaborator_id == user.id && up.permission == "edit")
  end
end