class ChangeStatusDataTypeToProjects < ActiveRecord::Migration
  def up
    change_column :projects, :status, :string, null: false, default: "In Progress"
  end

  def down
    change_column :projects, :status, :boolean, null: false, default: false
  end
end
