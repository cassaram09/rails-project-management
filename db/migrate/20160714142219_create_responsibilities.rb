class CreateResponsibilities < ActiveRecord::Migration
  def change
    create_table :responsibilities do |t|
      t.belongs_to :user
      t.string :name
      t.string :description
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end
