class Product < ApplicationRecord
    after_initialize :set_defaults   
    before_save :capitalize_title
    
    validates :title, presence: true, uniqueness: {case_sensitive: false}
    validates :price, numericality: {greater_than: 0}
    validates :description, presence: true, length: {minimum: 10}


    def set_defaults
        self.price ||= 1
    end

    def capitalize_title
        self.title.capitalize!
    end


end
