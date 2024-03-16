class CreateBasketProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :basket_products do |t|
      t.integer :count, default: 1

      t.timestamps
    end
    add_reference :basket_products, :basket, foreign_key: true
    add_reference :basket_products, :product, foreign_key: true
  end
end
