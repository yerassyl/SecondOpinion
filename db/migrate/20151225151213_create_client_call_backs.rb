class CreateClientCallBacks < ActiveRecord::Migration
  def change
    create_table :client_call_backs do |t|
      t.string :name
      t.string :country
      t.string :phone
      t.string :language
      t.string :email
      t.string :specialization
      t.text :message
      t.boolean :didAgree
      t.string :code

      t.timestamps null: false
    end
  end
end
