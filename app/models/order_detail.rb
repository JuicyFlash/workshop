class OrderDetail < ApplicationRecord
  belongs_to :order, optional: true
  validates :first_name, :last_name, :city, :street, :house, :phone , presence: true

end
