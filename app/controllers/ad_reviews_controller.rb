class AdReviewsController < ApplicationController
  before_action :set_ad_review, only: %i[ show update destroy ]

  # GET /ad_reviews
  # GET /ad_reviews.json
  def index
    @ad_reviews = AdReview.all
  end

  # GET /ad_reviews/1
  # GET /ad_reviews/1.json
  def show
  end

  # POST /ad_reviews
  # POST /ad_reviews.json
  def create
    @ad_review = AdReview.new(ad_review_params)

    if @ad_review.save
      render :show, status: :created, location: @ad_review
    else
      render json: @ad_review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ad_reviews/1
  # PATCH/PUT /ad_reviews/1.json
  def update
    if @ad_review.update(ad_review_params)
      render :show, status: :ok, location: @ad_review
    else
      render json: @ad_review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ad_reviews/1
  # DELETE /ad_reviews/1.json
  def destroy
    @ad_review.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_review
      @ad_review = AdReview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ad_review_params
      params.require(:ad_review).permit(:user_id, :ad_id, :rating, :comment)
    end
end
