require "test_helper"

class FavouriteAdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @favourite_ad = favourite_ads(:one)
  end

  test "should get index" do
    get favourite_ads_url, as: :json
    assert_response :success
  end

  test "should create favourite_ad" do
    assert_difference("FavouriteAd.count") do
      post favourite_ads_url, params: { favourite_ad: { ad_id: @favourite_ad.ad_id, user_id: @favourite_ad.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show favourite_ad" do
    get favourite_ad_url(@favourite_ad), as: :json
    assert_response :success
  end

  test "should update favourite_ad" do
    patch favourite_ad_url(@favourite_ad), params: { favourite_ad: { ad_id: @favourite_ad.ad_id, user_id: @favourite_ad.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy favourite_ad" do
    assert_difference("FavouriteAd.count", -1) do
      delete favourite_ad_url(@favourite_ad), as: :json
    end

    assert_response :no_content
  end
end
