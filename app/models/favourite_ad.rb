class FavouriteAd < ApplicationRecord
  belongs_to :user
  belongs_to :ad
end
