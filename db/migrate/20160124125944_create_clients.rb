class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.belongs_to :user, index: true
      t.string :country
      t.string :phone
      t.string :language
      t.timestamps null: false
    end
  end
end
