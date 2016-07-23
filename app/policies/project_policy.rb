class ProjectPolicy < ApplicationPolicy

  def update?
    up = UserProject.find_by(collaborator_id: user.id, collaboration_project_id: record.id )
    user.admin? || record.owner == user || !up.nil? || (up.collaborator_id == user.id && up.permission == "edit")
  end

  def show?
    up = UserProject.find_by(collaborator_id: user.id, collaboration_project_id: record.id )
    user.admin? || record.owner == user || !up.nil?
  end

  def edit?
    up = UserProject.find_by(collaborator_id: user.id, collaboration_project_id: record.id )
    user.admin? || record.owner == user || !up.nil?
  end

  def destroy?
    user.admin? || record.owner == user
  end

end