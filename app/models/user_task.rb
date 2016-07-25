class UserTask < ActiveRecord::Base
  belongs_to :assigned_task, class_name: "Task"
  belongs_to :assigned_user, class_name: "User"

  enum permission: [:View, :Edit]

  scope :projects, ->  (project_id) { where("collaboration_project_id = ?", project_id )}
end
