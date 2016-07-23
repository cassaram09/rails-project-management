class CreateUserProjects < ActiveRecord::Migration
  def change
    create_table :user_projects do |t|
      t.belongs_to :collaborator, class_name: "User"
      t.belongs_to :collaboration_project, class_name: "Project"
      t.integer :permission, default: 0
    end
  end
end




