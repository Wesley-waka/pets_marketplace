class CreateProfiles < ActiveRecord::Migration[7.0]
  def up
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.integer :account_type
      t.string :language
      t.string :location
      t.string :facebook_url
      t.string :twitter_url
      t.string :linkedin_url
      t.string :whatsapp_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :profiles
  end
end
