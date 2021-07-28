class ProductSerializer < ActiveModel::Serializer
  attributes(
    :id, 
    :title,
    :description,
    :price,
    :created_at,
    :updated_at,
    :favourites_count
  )

  #-----------------------------Associations--------------->

  belongs_to :user, key: :seller

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :email, :full_name
  end

  has_many :reviews
  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :body, :rating

    def seller_full_name
      object.user&.full_name
    end
  end

  #-----------------------Custom methods and attributes to render in JSON format--->

  def favourites_count
    #object refers to the instance of the model being serialized.  
    #Kind of like "this" in JS or "self" in Ruby
    object.favourites.count
  end
end