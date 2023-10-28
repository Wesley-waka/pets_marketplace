class AddStatusToAds < ActiveRecord::Migration[7.0]
  def change
    add_column :ads, :status, :integer, default: 0
  end
end
