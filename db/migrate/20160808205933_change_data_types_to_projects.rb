class ChangeDataTypesToProjects < ActiveRecord::Migration
  def up
    change_column :projects, :date_started, :date
    change_column :projects, :date_completed, :date
    change_column :projects, :deadline, :date
    change_column_null :projects, :date_started, true
  end

  def down
    change_column :projects, :date_started, :string
    change_column :projects, :date_completed, :string
    change_column :projects, :deadline, :string
    change_column_null :projects, :date_started, false
  end
end
