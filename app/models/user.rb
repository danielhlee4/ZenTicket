class User < ApplicationRecord
    has_secure_password

    validates :email,
        presence: true,
        uniqueness: true, 
        length: { in: 3..255 }, 
        format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password,
        length: { in: 6..255 }, allow_nil: true

    has_many :tickets, dependent: :destroy
end
