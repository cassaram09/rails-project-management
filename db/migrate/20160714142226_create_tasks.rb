class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :project
      t.belongs_to :user
      t.string :name
      t.string :description
      t.date :due_date
      t.integer :status, default: 0
      t.integer :priority, default: 0
      t.timestamps null: false
    end
  end
end
