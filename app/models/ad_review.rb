class AdReview < ApplicationRecord
  belongs_to :user
  belongs_to :ad
end
