class User < ApplicationRecord

  has_one :basket, dependent: :destroy
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :password, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Incorrect email format", on: [:create, :update] },
            uniqueness: { on: [:create, :update] }

end
