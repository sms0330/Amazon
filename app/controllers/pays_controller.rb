class PaysController < ApplicationController
    def new
        @pay = Pay.new
    end

    def create
        @pay = Pay.new(pay_params)
        @product = Product.find params[:product_id]
        @pay.sender = current_user
        @pay.status = "pending"
        # @pay.security_key = "this is security key"
        @pay.security_key = SecureRandom.hex(20)
        @pay.receiver = @product.user
        @pay.product = @product

        if @pay.save
            shared_path = "http://localhost:5000/products/#{@product.id}/pays/complete?pay_id=#{@pay.id}&security_key=#{@pay.security_key}"
            session = Stripe::Checkout::Session.create({
                # success_url: shared_path + '/success',
                success_url: shared_path + '&status=completed',
                # cancel_url: shared_path + '/cancel',
                cancel_url: shared_path + '&status=canceled',
                payment_method_types: ['card'],
                line_items: [{
                    amount: @pay.amount * 100,
                    currency: "cad",
                    name: "pay for good product",
                    quantity: 1,
                    images: [
                        'https://thebritishschoolofetiquette.com/wp-content/uploads/2018/12/Article-Size-Pictures7.jpg'
                    ]
                }],
                mode: "payment"
            })

            redirect_to session.url
            # puts session
            # flash[:notice] = "pay was created"
            # redirect_to root_path
        else
            render :new
        end
    end

    def complete
        @pay = Pay.find params[:pay_id]
        @pay.status = params[:status]
        @pay.save
        if @pay.status == "completed"
            flash[:notice] = "You paid successfully!"
        else
            flash[:alert] = "Pay not completed"
        end
        redirect_to root_path
    end

    private

    def pay_params
        params.require(:pay).permit(:amount)
    end
end
