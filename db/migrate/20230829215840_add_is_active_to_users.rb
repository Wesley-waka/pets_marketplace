class AddIsActiveToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :is_active, :boolean, default: false
    add_column :users, :activation_token, :string
    add_column :users, :activation_token_expires_at, :datetime
  end

  def down
    remove_column :users, :is_active, :boolean, default: false
    remove_column :users, :activation_token, :string
    remove_column :users, :activation_token_expires_at, :datetime
  end
end
