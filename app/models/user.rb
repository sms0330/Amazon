class User < ApplicationRecord
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify
    has_many :news_articles, dependent: :nullify

    # lab for many to many
    has_many :likes
    has_many :liked_reviews, through: :likes, source: :review

    has_many :favourites
    has_many :favourited_products, through: :favourites, source: :product

    # lab for more many to many
    has_many :votes
    has_many :vote_reviews, through: :votes, source: :review

    has_secure_password

    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :first_name, presence: true
    validates :last_name, presence: true
    
    def full_name
        "#{first_name} #{last_name}".strip.titlecase
    end
end
