class CreateMedicalHistories < ActiveRecord::Migration
  def change
    create_table :medical_histories do |t|
      t.text :reason
      t.boolean :smoke, default: false
      t.boolean :drink, default: false
      t.boolean :pregnant, default: false
      t.belongs_to :patient, index: true
      t.timestamps null: false
    end
  end
end
