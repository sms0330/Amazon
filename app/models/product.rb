class Product < ApplicationRecord
    after_initialize :set_defaults   
    before_save :capitalize_title

    # lab for many to many
    has_many :favourites, dependent: :destroy
    has_many :favouriters, through: :favourites, source: :user
    
    validates :title, presence: true, uniqueness: {case_sensitive: false}
    validates :price, numericality: {greater_than: 0}
    validates :description, presence: true, length: {minimum: 10}

    has_many :reviews, dependent: :destroy

    belongs_to :user, optional: true

    # A callback method to set the default price to 1
    # A callback method to capitalize the product title before saving
    private
    def set_defaults
        self.price ||= 1
    end

    def capitalize_title
        self.title.capitalize!
    end


end
