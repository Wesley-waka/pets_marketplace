class FavouriteAdsController < ApplicationController
  before_action :set_favourite_ad, only: %i[ show update destroy ]

  # GET /favourite_ads
  # GET /favourite_ads.json
  def index
    @favourite_ads = FavouriteAd.all
  end

  # GET /favourite_ads/1
  # GET /favourite_ads/1.json
  def show
  end

  # POST /favourite_ads
  # POST /favourite_ads.json
  def create
    @favourite_ad = FavouriteAd.new(favourite_ad_params)

    if @favourite_ad.save
      render :show, status: :created, location: @favourite_ad
    else
      render json: @favourite_ad.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /favourite_ads/1
  # PATCH/PUT /favourite_ads/1.json
  def update
    if @favourite_ad.update(favourite_ad_params)
      render :show, status: :ok, location: @favourite_ad
    else
      render json: @favourite_ad.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favourite_ads/1
  # DELETE /favourite_ads/1.json
  def destroy
    @favourite_ad.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favourite_ad
      @favourite_ad = FavouriteAd.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favourite_ad_params
      params.require(:favourite_ad).permit(:user_id, :ad_id)
    end
end
