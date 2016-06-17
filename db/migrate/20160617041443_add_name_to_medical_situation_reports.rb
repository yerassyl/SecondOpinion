class AddNameToMedicalSituationReports < ActiveRecord::Migration
  def change
    add_column :medical_situation_reports, :name, :string
  end
end
