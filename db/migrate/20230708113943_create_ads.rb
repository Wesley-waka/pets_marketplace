class CreateAds < ActiveRecord::Migration[7.0]
  def change
    create_table :ads do |t|
      t.string :name
      t.integer :gender, default: 0
      t.string :breed
      t.string :pet_type, null:false
      t.float :price, null: false
      t.text :description
      t.integer :age
      t.string :country
      t.string :city
      t.string :zipcode
      t.string :email
      t.string :phone_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
