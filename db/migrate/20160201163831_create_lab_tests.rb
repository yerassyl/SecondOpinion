class CreateLabTests < ActiveRecord::Migration
  def change
    create_table :lab_tests do |t|
      t.string :name
      t.text :description
      t.string :file
      t.belongs_to :medical_history, index:true
      t.timestamps null: false
    end
  end

end
