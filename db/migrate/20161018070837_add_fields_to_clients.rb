class AddFieldsToClients < ActiveRecord::Migration
  def change
  	add_column :clients, :address, :string
  	add_column :clients, :city, :string
  	add_column :clients, :state, :string
  	add_column :clients, :zipcode, :string
  	add_column :clients, :cellphone, :string
  end
end
