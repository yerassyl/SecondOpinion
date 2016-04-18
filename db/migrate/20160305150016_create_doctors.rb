class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :email
      t.string :name
      t.string :phone_number
      t.string :address
      t.string :resume
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
