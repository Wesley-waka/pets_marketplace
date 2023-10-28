class Ad < ApplicationRecord
  
  # associations
  belongs_to :user
   has_many :ad_reviews, dependent: :destroy
  has_many :favourite_ads, dependent: :destroy
  # enumerations
  enum gender: [:male, :female]
  enum status: %i[unapproved approved]

  # validations
  validates :pet_type, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  has_one_attached :pet_image
  # callbacks
  # before_create :set_ad_price_and_payment_from_stripe


  # def set_ad_price_and_payment_from_stripe
  # end

end
