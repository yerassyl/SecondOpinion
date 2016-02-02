class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.string :name
      t.belongs_to :medical_history, index: true
      t.timestamps null: false
    end
  end
end
