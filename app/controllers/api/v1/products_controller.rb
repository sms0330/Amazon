class Api::V1::ProductsController <  Api::ApplicationController
    before_action :find_product, only: [:show, :destroy, :update]
    before_action :authenticate_user!, only: [ :create, :destroy, :update ]

    def index
        products = Product.order(created_at: :desc)
        render(json: products, each_serializer: ProductCollectionSerializer)
    end

    def show
        render(json: @product)
    end

    def create
        product = Product.new product_params
        product.user = current_user

        if product.save
            render json: { id: product.id }
        else
            render(
                json: { errors: product.errors.messages },
                status: 422 #Unprocessable entity
            )
        end
    end

    def destroy
        @product.destroy
        render json: { status: 200 }, status: 200
    end
  
    def update
        if @product.update product_params
            render json: @product
        else
            render(
            json: { errors: @product.errors },
            status: 422 
            )
        end
    end

    private

    def find_product
        @product ||= Product.find params[:id]
    end

    def product_params
        params.require(:product).permit(:title, :description, :price)
    end

end
