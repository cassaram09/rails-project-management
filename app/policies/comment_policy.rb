class CommentPolicy < ApplicationPolicy
  def edit?
    user.admin? || project_owner? || task_owner? || record_owner?
  end

  def update?
    user.admin? || project_owner? || task_owner? || record_owner?
  end

  def destroy?
    user.admin? || project_owner? || task_owner? || record_owner?
  end
end