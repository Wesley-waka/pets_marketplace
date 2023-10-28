class CreateProductType < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :category
      t.string :price_key
      t.timestamps
    end
  end
end
