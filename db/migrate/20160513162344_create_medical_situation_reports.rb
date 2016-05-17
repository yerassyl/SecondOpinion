class CreateMedicalSituationReports < ActiveRecord::Migration
  def change
    create_table :medical_situation_reports do |t|
      t.string :file
      t.string :description
      t.belongs_to :medical_situation, index:true
      t.timestamps null: false
    end
  end
end
