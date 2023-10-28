require "test_helper"

class AdReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ad_review = ad_reviews(:one)
  end

  test "should get index" do
    get ad_reviews_url, as: :json
    assert_response :success
  end

  test "should create ad_review" do
    assert_difference("AdReview.count") do
      post ad_reviews_url, params: { ad_review: { ad_id: @ad_review.ad_id, comment: @ad_review.comment, rating: @ad_review.rating, user_id: @ad_review.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show ad_review" do
    get ad_review_url(@ad_review), as: :json
    assert_response :success
  end

  test "should update ad_review" do
    patch ad_review_url(@ad_review), params: { ad_review: { ad_id: @ad_review.ad_id, comment: @ad_review.comment, rating: @ad_review.rating, user_id: @ad_review.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy ad_review" do
    assert_difference("AdReview.count", -1) do
      delete ad_review_url(@ad_review), as: :json
    end

    assert_response :no_content
  end
end
