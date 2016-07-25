class CommentPolicy < ApplicationPolicy
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
    user.admin? || comment_project_owner? || task_owner? || record_owner?
  end
end