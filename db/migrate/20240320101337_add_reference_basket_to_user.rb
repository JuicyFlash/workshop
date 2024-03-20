class AddReferenceBasketToUser < ActiveRecord::Migration[7.1]
  def change
  end
  add_reference :baskets, :user, foreign_key: true
end
