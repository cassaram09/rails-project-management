class ProjectPolicy < ApplicationPolicy

  def update?
    binding.pry
    up = UserProject.find_by(collaborator_id: user.id, collaboration_project_id: record.id )
    user.admin? || record.owner == user || (up.collaborator_id == user.id && up.permission == "edit")
  end

end