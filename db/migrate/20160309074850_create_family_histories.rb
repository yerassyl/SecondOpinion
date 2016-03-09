class CreateFamilyHistories < ActiveRecord::Migration
  def change
    create_table :family_histories do |t|
      t.string :alive
      t.string :age
      t.string :relationship
      t.string :other_information
      t.string :email
      t.string :skype
      t.belongs_to :patient, index: true
      t.timestamps null: false
    end
  end
end
