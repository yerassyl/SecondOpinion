class CreateDiseases < ActiveRecord::Migration
  def change
    create_table :diseases do |t|
      t.string :diagnose
      t.string :condition
      t.string :treatment
      t.text :other
      t.belongs_to :patient, index: true
      t.timestamps null: false
    end
  end
end
