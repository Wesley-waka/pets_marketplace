json.extract! ad_review, :id, :user_id, :ad_id, :rating, :comment, :created_at, :updated_at
json.url ad_review_url(ad_review, format: :json)
