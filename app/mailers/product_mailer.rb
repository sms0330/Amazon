class ProductMailer < ApplicationMailer
    def hello_world
        mail(
            to: 'stephanie@codecore.ca',
            from: 'anyone@example.com',
            cc: 'someone.else@example.com',
            bcc: 'another.person@example.com',
            subject: 'Hello World'
        )
    end

    def new_product(product)
        @product = product
        @owner = @product.user
        mail(
            to: @owner.email,
            subject: "#{@product.user.first_name}, your product is succesfully created"
        )
    end

    def new_review(review)
        @review = review
        @product = review.product
        @owner = @product.user
        mail(to: @owner.email, subject: 'You got a new review')
    end
end
