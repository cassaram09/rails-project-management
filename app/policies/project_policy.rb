class ProjectPolicy < ApplicationPolicy

  def update?
    user.admin? || record.owner == user || (project.collaborators.include?(user) && user.permission == "edit")
  end

end