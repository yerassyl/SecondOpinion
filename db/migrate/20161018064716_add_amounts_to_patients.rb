class AddAmountsToPatients < ActiveRecord::Migration
  def change
  	add_column :patients, :amount_due, :integer, :null => :false, :default => 0
  	add_column :patients, :amount_paid, :integer, :null => :false, :default => 0
  end
end
