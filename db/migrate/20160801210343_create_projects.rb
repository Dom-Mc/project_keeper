class CreateProjects < ActiveRecord::Migration

  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description
      t.string :date_started, null: false
      t.string :date_completed
      t.string :deadline
      t.text :notes
      t.boolean :status, null: false, default: false
      t.references :user
      t.timestamps
    end
    add_index :projects, :name
  end

end
