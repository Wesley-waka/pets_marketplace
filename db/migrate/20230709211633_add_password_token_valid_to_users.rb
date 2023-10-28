class AddPasswordTokenValidToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :password_token_valid, :boolean, default: false
  end

  def down
    remove_column :users, :password_token_valid, :boolean, default: false
  end
end
