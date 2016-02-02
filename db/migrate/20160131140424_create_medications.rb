class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.string :name
      t.string :dose
      t.integer :per_day
      t.text :other
      t.belongs_to :medical_history, index:true
      t.timestamps null: false
    end
  end
end
