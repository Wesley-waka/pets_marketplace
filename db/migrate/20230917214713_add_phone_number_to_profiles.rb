class AddPhoneNumberToProfiles < ActiveRecord::Migration[7.0]
  def up
    add_column :profiles, :phone_number, :string
  end

  def down
    remove_column :profiles, :phone_number, :string
  end
end
