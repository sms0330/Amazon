class Api::V1::ProductsController <  Api::ApplicationController
    before_action :find_product, only: [:show, :destroy, :update]
    before_action :authenticate_user!, only: [ :create, :destroy, :update ]

    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        products = Product.order(created_at: :desc)
        render(json: products)
    end

    def show
        if @product
            render(json: @product)
        else
            render(json: {error: "Product Not Found"})
        end
    end

    def create
        product = Product.new product_params
        product.user = current_user

        # if product.save
        #     render json: { id: product.id }
        # else
        #     render(
        #         json: { errors: product.errors.messages },
        #         status: 422 
        #     )
        # end
        product.save!
        render json: {id: product.id}
    end

    def destroy
        # @product.destroy
        # render json: { status: 200 }, status: 200
        if @product || @product.destroy
            head :ok
        else
            head :bad_request
        end
    end
  
    def update
        # if @product.update product_params
        #     render json: @product
        # else
        #     render(
        #     json: { errors: @product.errors },
        #     status: 422 
        #     )
        # end
        @product.update pr@product_params
        render json: { id: @product.id }
    end

    private

    def find_product
        @product ||= Product.find params[:id]
    end

    def product_params
        params.require(:product).permit(:title, :description, :price)
    end

    def record_invalid(error)
        invalid_record = error.record
        errors = invalid_record.errors.map do |field, message|
            {
                type: error.class.to_s, #need it in string format
                record_type: invalid_record.class.to_s,
                field: field,
                message: message
            }
        end
        render(
            json: {status: 422, errors: errors },
            status: 422 #alias is :unprocessable_entity
        )
    end

end
