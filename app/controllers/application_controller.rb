class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_guest_user
  # get current guest user
  def current_guest_user
  	@current_guest_user=Spree::GuestUser.find_by_email(current_order.try(:email))	if current_order.present? && current_spree_user.blank?
  end
end
