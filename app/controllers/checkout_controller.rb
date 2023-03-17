class CheckoutController < ApplicationController
  # before_action :success, only: [:create]

  def create
    @total = params[:total].to_d
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total * 100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout'
            }
          },
          quantity: 1
        }
      ],
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    redirect_to @session.url, allow_other_host: true
  end

  def success
    create_order
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    current_user.orders.last.validate_payment
    Cart.empty_for(current_user)
  end

  def cancel
    cancel_order
  end

  private

  def create_order
    @order = Order.create_for(current_user)
    @order.import_cart(current_user.cart)
  end

  def cancel_order
    current_user.orders.last.destroy
  end
end
