class OrderDetail < ApplicationRecord
  belongs_to :order, optional: true
  validates_presence_of :first_name, message: "Поле имя не заполнено"
  validates_presence_of :last_name, message: "Поле фамилия не заполнено"
  validates_presence_of :city, message: "Поле город не заполнено"
  validates_presence_of :street, message: "Поле улица не заполнено"
  validates_presence_of :house, message: "Поле дом не заполнено"
  validates_presence_of :phone, message: "Поле телефон не заполнено"
end
