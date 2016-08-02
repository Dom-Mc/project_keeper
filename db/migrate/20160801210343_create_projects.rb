class CreateProjects < ActiveRecord::Migration

  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :date_completed
      t.integer :user_id
    end
  end

end
