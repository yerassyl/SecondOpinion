class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :address
      t.string :resume

      t.timestamps null: false
    end
  end
end
