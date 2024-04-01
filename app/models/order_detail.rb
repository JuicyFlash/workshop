class OrderDetail < ApplicationRecord
  belongs_to :order
  validates :first_name, :last_name, :city, :street, :house, :phone, presence: true

end
