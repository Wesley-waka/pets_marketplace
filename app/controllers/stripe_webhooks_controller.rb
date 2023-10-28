class StripeWebhooksController < ApplicationController
    def receive
        payload = request.body.read
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
        event = nil
    
        begin
            event = Stripe::Webhook.construct_event( payload, sig_header, 'whsec_GqaKvOPn2AVcEJaY0BOfy7gkM0MolbzA')
        rescue JSON::ParserError => e
            # Invalid payload
            status 400
            return
        rescue Stripe::SignatureVerificationError => e
            # Invalid signature
            status 400
            return
        end
    
        # Handle the event
        case event.type
        when 'checkout.session.async_payment_failed'
            session = event.data.object
        when 'checkout.session.async_payment_succeeded'
            session = event.data.object
        when 'checkout.session.completed'
            session = event.data.object
            ad_id = session.metadata.associated_ad
            ad = Ad.find(ad_id).approved! if ad_id.present?
        when 'checkout.session.expired'
            session = event.data.object
        # ... handle other event types
        else
            puts "Unhandled event type: #{event.type}"
        end
    
        render json: { success: true }, status: 200
    end
end
