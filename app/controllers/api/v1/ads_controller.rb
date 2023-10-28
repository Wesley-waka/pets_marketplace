module Api
  module V1
    class AdsController < ApiController
      before_action :find_ad, only: [:show, :update, :destroy]

      def index
        if params.blank?
          pets_search(params)
        else
          @ads = Ad.includes(pet_image_attachment: :blob).all
          render json: @ads.map { |ad| ad.as_json.merge(pet_image_url: image_url(ad), user: ad.user) }        
        end
      end

      def show
      end

      def create
        @ad = Ad.new(ad_params)
        @ad.user = current_user

        if @ad.save
          @price_key = Product.find_by(category: params[:ad][:ad_type]).price_key
          payment_link_service = StripePaymentLinkService.new(@ad, @price_key)
          payment_link = payment_link_service.create_payment_link
          render json: { ad: @ad, pet_image_url: image_url(@ad), checkout_link: payment_link.url, metadata: payment_link.metadata }
        else
          render json: { error: @ad.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @ad.update(ad_params)
          render 'update'
        else
          render json: { error: @ad.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @ad.destroy
      end


      private

      def create_stripe_payment_link(ad)
        Stripe::PaymentLink.create(
          amount: calculate_ad_price(ad) * 100, # Stripe amounts are in cents
          currency: 'usd', # Adjust to your currency
          description: 'Ad payment',
          refresh_url: ad_url(ad), # URL to return to if the payment session is canceled
          return_url: ad_url(ad) # URL to return to after a successful payment
        )
      end

      def image_url(ad)
        if ad.pet_image.attached?
          rails_blob_url(ad.pet_image.blob)
        end
      end
      
      def find_ad
        @ad = Ad.find(params[:id])
      end

      def ad_params
        params.require(:ad).permit!
      end

      def pets_search(search_params)
        @ads = Ad.all
        if params[:pet_type].present?
          @ads = @ads.where(pet_type: params[:pet_type])
        elsif params[:country_name].present?
          @ads = @ads.where(country: params[:country_name])
        elsif params[:by_name].present?
          @ads = @ads.where(name: params[:by_name])
        elsif params[:by_age].present?
          min_age = params[:by_age][:min_age]&.to_i
          max_age = params[:by_age][:max_age]&.to_i
          @ads = @ads.where(age: min_age..max_age)
        elsif params[:time_range].present?
          case params[:time_range]
          when "last_hour"
            time_range = 1.hour.ago..Time.current
          when "last_24_hours"
            time_range = 24.hours.ago..Time.current
          when "last_7_days"
            time_range = 7.days.ago..Time.current
          when "last_14_days"
            time_range = 14.days.ago..Time.current
          when "last_30_days"
            time_range = 30.days.ago..Time.current
          else
            time_range = 7.days.ago..Time.current
          end
          @ads = @ads.where(created_at: time_range)
        end
      end
    end
  end
end
