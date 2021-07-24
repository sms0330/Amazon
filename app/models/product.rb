class Product < ApplicationRecord
    after_initialize :set_defaults   
    before_save :capitalize_title

    # lab for many to many
    has_many :favourites, dependent: :destroy
    has_many :favouriters, through: :favourites, source: :user

    # lab for more many to many 
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    
    
    validates :title, presence: true, uniqueness: {case_sensitive: false}
    validates :price, numericality: {greater_than: 0}
    validates :description, presence: true, length: {minimum: 10}

    has_many :reviews, dependent: :destroy

    belongs_to :user, optional: true

    # A callback method to set the default price to 1
    # A callback method to capitalize the product title before saving

        #------------ADD CUSTOM TAG METHODS TO GET OR SET TAGS WITH SELECTIZE----------------------------->

    #Getter
    def tag_names
        self.tags.map(&:name).join(", ")
    end
    
    #Setter
    def tag_names=(rhs)
        self.tags = rhs.strip.split(/\s*,\s*/).map do |tag_name|
            Tag.find_or_initialize_by(name: tag_name)
        end
    end

    private
    def set_defaults
        self.price ||= 1
    end

    def capitalize_title
        self.title.capitalize!
    end


end
