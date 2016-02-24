class CreateMedicalSituations < ActiveRecord::Migration
  def change
    create_table :medical_situations do |t|
      t.string :reason
      t.belongs_to :patient, index: true
      t.timestamps null: false
    end
  end
end
