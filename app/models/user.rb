class User < ApplicationRecord
    geocoded_by :address
    after_validation :geocode

    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :news_articles, dependent: :nullify

    # lab for many to many
    has_many :likes
    has_many :liked_reviews, through: :likes, source: :review

    has_many :favourites
    has_many :favourited_products, through: :favourites, source: :product

    # lab for more many to many
    has_many :votes
    has_many :vote_reviews, through: :votes, source: :review

    has_many :sent_pays, class_name: 'Pay', foreign_key: :sender_id, dependent: :nullify
    has_many :received_pays, class_name: 'Pay', foreign_key: :receiver_id, dependent: :nullify

    has_secure_password

    validates :email, presence: true, uniqueness: { case_sensitive: false }, unless: :from_oauth?
    validates :first_name, presence: true
    validates :last_name, presence: true
    
    def full_name
        "#{first_name} #{last_name}".strip.titlecase
    end

    def from_oauth?
        uid.present? && provider.present?
    end

    def self.create_from_oauth(oauth_data)
        name = oauth_data["info"]["name"]&.split || oauth_data["info"]["nickname"]
        self.create(
            first_name: name[0],
            last_name: name[1] || "",
            uid: oauth_data["uid"],
            provider: oauth_data["provider"],
            oauth_raw_data: oauth_data,
            password: SecureRandom.hex(32)
        )
    end

    def self.find_by_oauth(oauth_data)
        self.find_by(
            uid: oauth_data["uid"],
            provider: oauth_data["provider"]
        )
    end
end
