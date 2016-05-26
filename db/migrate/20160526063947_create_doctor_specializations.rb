class CreateDoctorSpecializations < ActiveRecord::Migration
  def change
    create_table :doctor_specializations do |t|
      t.belongs_to :doctor, index:true
      t.belongs_to :specialization, index:true
      t.timestamps null: false
    end
  end
end
