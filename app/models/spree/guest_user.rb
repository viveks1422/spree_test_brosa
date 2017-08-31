class Spree::GuestUser < ApplicationRecord
	has_many :wishlists, dependent: :destroy,foreign_key: :user_id
end
