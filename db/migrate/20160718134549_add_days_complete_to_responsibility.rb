class AddDaysCompleteToResponsibility < ActiveRecord::Migration
  def change
    add_column :responsibilities, :days_complete, :integer, default: 0
  end
end
