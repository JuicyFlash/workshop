class OrderDetail < ApplicationRecord
  belongs_to :order, optional: true
  validates :first_name, presence: { message: "Поле имя не заполнено" }
  validates :last_name, presence: {  message: "Поле фамилия не не заполнено" }
  validates :city, presence: {  message: "Поле город не не заполнено" }
  validates :street, presence: { message: "Поле улица не не заполнено" }
  validates :house, presence: { message: "Поле дом не не заполнено" }
  validates :phone, presence: { message: "Поле телефон не не заполнено" }
end
