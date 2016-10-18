class AddAmountsToMedicalSituations < ActiveRecord::Migration
  def change
  	add_column :medical_situations, :client_amount_paid, :integer, :null => :false, :default => 0
  	add_column :medical_situations, :doctor_amount_paid, :integer, :null => :false, :default => 0
  end
end
