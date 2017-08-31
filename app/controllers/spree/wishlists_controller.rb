class Spree::WishlistsController < Spree::StoreController
  # before_action :check_authorization
  helper 'spree/products'

  before_action :find_wishlist, only: [:destroy, :show, :update, :edit]

  respond_to :html
  respond_to :js, only: :update

  def new
    @wishlist = Spree::Wishlist.new
    # respond_with(@wishlist)
  end

  def index

    @wishlists = spree_current_user.wishlists if spree_current_user
    @wishlists = current_guest_user.wishlists if current_guest_user
    # respond_with(@wishlists)
  end

  def edit
    respond_with(@wishlist)
  end

  def update
    @wishlist.update_attributes wishlist_attributes
    respond_with(@wishlist)
  end

  def show
    respond_with(@wishlist)
  end

  def default
    @wishlist = spree_current_user.wishlist if spree_current_user
    respond_with(@wishlist) do |format|
      format.html { render :show }
    end
  end

  def create
    @wishlist = Spree::Wishlist.new wishlist_attributes
    @wishlist.user = spree_current_user if spree_current_user
    @wishlist.guest_user = current_guest_user if current_guest_user
    @wishlist.save
    respond_with(@wishlist)
  end

  def destroy
    @wishlist.destroy
    respond_with(@wishlist) do |format|
      format.html { redirect_to account_path }
    end
  end

  private

  def wishlist_attributes
    params.require(:wishlist).permit(:name, :is_default, :is_private)
  end

  # Isolate this method so it can be overwritten
  def find_wishlist
    @wishlist = Spree::Wishlist.find_by_access_hash!(params[:id])
  end
end