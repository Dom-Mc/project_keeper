class CreateProjects < ActiveRecord::Migration

  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description
      t.date :date_started
      t.date :date_completed
      t.date :deadline
      t.text :notes
      t.string :status, null: false, default: "In Progress"
      t.references :user
      t.timestamps
    end
    add_index :projects, :name
  end

end
