# app/services/stripe_payment_link_service.rb

class StripePaymentLinkService
  def initialize(ad, price_key)
    @ad = ad
    @price_key = price_key
  end

  def create_payment_link
    Stripe::PaymentLink.create({
      line_items: [
        {
          price: @price_key,
          quantity: 1
        },
      ],
      metadata: {
        associated_ad: @ad.id
      },
      after_completion: {
        type: 'redirect',
        redirect: {url: ENV["CLIENT_SIDE"]},
      },
    } )
  end

end
