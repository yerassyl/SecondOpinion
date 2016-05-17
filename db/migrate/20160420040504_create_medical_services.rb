class CreateMedicalServices < ActiveRecord::Migration
  def change
    create_table :medical_services do |t|
      t.string :description
      t.integer :price
      t.integer :fee
      t.belongs_to :medical_situation, index:true
      t.belongs_to :specialization, index:true
      t.timestamps null: false
    end
  end
end
