class CreateMedicalSituations < ActiveRecord::Migration
  def change
    create_table :medical_situations do |t|
      t.string :reason
      t.belongs_to :patient, index: true
      t.belongs_to :doctor, index: true
      t.belongs_to :pool, index:true
      t.boolean :paid, default: false
      t.integer :price
      t.boolean :inPool, default: false
      t.timestamps null: false
    end
  end
end
