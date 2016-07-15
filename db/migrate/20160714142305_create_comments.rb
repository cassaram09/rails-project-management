class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :task
      t.string :name
      t.string :description
      t.timestamps null: false
    end
  end
end
