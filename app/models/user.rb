class User < ApplicationRecord

  has_one :basket, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :password, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Incorrect email format", on: [:create, :update] },
            uniqueness: { on: [:create, :update] }

  after_create :create_user_basket

  private
  def create_user_basket
     Basket.create(user: self)
  end
end
