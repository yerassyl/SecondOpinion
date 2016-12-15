class AddPaidToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :paid, :boolean, :default => :false
  end
end
