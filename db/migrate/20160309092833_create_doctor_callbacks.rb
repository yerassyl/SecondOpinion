class CreateDoctorCallbacks < ActiveRecord::Migration
  def change
    create_table :doctor_callbacks do |t|
      t.string :name
      t.string :email
      t.string :resume

      t.timestamps null: false
    end
  end
end
