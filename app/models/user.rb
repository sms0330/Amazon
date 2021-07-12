class User < ApplicationRecord
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify
    has_secure_password

    def full_name
        "#{first_name} #{last_name}"
    end
end
