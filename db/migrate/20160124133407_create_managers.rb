class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
