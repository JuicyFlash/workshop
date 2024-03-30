class BasketProduct < ApplicationRecord

  belongs_to :basket
  belongs_to :product

  validates :count, numericality: { greater_than_or_equal_to: 0 }

end
