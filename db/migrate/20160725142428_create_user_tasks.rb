class CreateUserTasks < ActiveRecord::Migration
  def change
    create_table :user_tasks do |t|
      t.belongs_to :assigned_user, class_name: "User"
      t.belongs_to :assigned_task, class_name: "Task"
      t.timestamps null: false
    end
  end
end
