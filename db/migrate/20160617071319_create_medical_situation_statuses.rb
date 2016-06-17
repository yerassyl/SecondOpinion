class CreateMedicalSituationStatuses < ActiveRecord::Migration
  def change
    create_table :medical_situation_statuses do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
