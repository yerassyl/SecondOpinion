class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :firstname, null:false
      t.string :middlename
      t.string :lastname, null:false
      t.date :birthday
      t.string :maritial_status
      t.boolean :gender
      t.string :email, null:false
      t.string :telephone
      t.string :cellphone
      t.string :emergency_person
      t.string :emergency_person_phone
      t.belongs_to :client, index:true

      t.timestamps null: false
    end
  end
end
