class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :count, numericality: { greater_than_or_equal_to: 1 }
end
