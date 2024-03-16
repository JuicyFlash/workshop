class User < ApplicationRecord

  validates :email, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Incorrect email format", on: [:create, :update] },
            uniqueness: { on: [:create, :update] }
end
