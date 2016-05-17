class CreateMedicalServiceDocuments < ActiveRecord::Migration
  def change
    create_table :medical_service_documents do |t|
      t.string :file
      t.string :name
      t.string :description
      t.belongs_to :medical_services, index:true
      t.timestamps null: false
    end
  end
end
