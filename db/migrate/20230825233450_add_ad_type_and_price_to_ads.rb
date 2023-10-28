class AddAdTypeAndPriceToAds < ActiveRecord::Migration[7.0]
  def up
    add_column :ads, :ad_type, :string
    add_column :ads, :ad_price, :integer, default: 0
  end

  def down
    remove_column :ads, :ad_type, :string
    remove_column :ads, :ad_price, :integer, default: 0
  end
end
