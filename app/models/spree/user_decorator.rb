Spree::User.class_eval do
	after_create :convert_guest_wishlist_to_user_list
	def convert_guest_wishlist_to_user_list
		guest_user=Spree::GuestUser.find_by_email(email) 
		unless guest_user.blank?
			guest_wishlists=guest_user.wishlists
			# loop
			guest_wishlists.each do |wishlist|
				debugger
				wishlist.guest_user_id=nil
				wishlist.user_id=id
				wishlist.save(validate: false)
			end
			guest_user.destroy
		end
	end
end
