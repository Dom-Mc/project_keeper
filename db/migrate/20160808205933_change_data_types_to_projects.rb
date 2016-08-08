class ChangeDataTypesToProjects < ActiveRecord::Migration
  def up
    change_column :projects, :date_started, :date, null: false
    change_column :projects, :date_completed, :date
    change_column :projects, :deadline, :date
  end

  def down
    change_column :projects, :date_started, :string, null: false
    change_column :projects, :date_completed, :string
    change_column :projects, :deadline, :string
  end
end
