class UserProject < ActiveRecord::Base
  belongs_to :collaboration_project, class_name: "Project"
  belongs_to :collaborator, class_name: "User"

  enum permission: [:View, :Edit]

  scope :projects, ->  (project_id) { where("collaboration_project_id = ?", project_id )}
end