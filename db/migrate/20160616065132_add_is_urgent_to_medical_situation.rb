class AddIsUrgentToMedicalSituation < ActiveRecord::Migration
  def change
    add_column :medical_situations, :is_urgent, :boolean
  end
end
