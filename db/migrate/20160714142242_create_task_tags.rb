class CreateTaskTags < ActiveRecord::Migration
  def change
    create_table :task_tags do |t|
      t.belongs_to :task
      t.belongs_to :tag
      t.timestamps null: false
    end
  end
end
