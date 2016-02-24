class CreateOtherDocuments < ActiveRecord::Migration
  def change
    create_table :other_documents do |t|
      t.string :name
      t.string :description
      t.string :file
      t.belongs_to :medical_situation, index: true
      t.timestamps null: false
    end
  end

end
