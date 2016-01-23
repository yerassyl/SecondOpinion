class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.belongs_to :user
      t.belongs_to :role
      t.timestamps null: false
    end
    add_index :assignments, :user_id, unique: true
    add_index :assignments, [:user_id,:role_id], unique: true
  end
end
