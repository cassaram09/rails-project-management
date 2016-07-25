class CommentPolicy < ApplicationPolicy
  def edit?
    user.admin? || comment_project_owner? || task_owner? || record_owner?
  end

  def update?
    user.admin? || comment_project_owner? || task_owner? || record_owner?
  end

  def destroy?
    user.admin? || comment_project_owner? || task_owner? || record_owner?
  end
end