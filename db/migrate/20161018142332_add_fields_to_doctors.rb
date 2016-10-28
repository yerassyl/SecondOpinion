class AddFieldsToDoctors < ActiveRecord::Migration
  def change
  	add_column :doctors, :emergency_phone, :string
  	add_column :doctors, :city, :string
  	add_column :doctors, :state, :string
  	add_column :doctors, :zipcode, :string
  	add_column :doctors, :country, :string
  end
end
