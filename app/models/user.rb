class User < ApplicationRecord
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify
    has_many :news_articles, dependent: :nullify

    has_secure_password

    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :first_name, presence: true
    validates :last_name, presence: true
    
    def full_name
        "#{first_name} #{last_name}".strip.titlecase
    end
end
