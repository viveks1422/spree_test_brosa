class CreateSpreeGuestUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_guest_users do |t|
      t.string :email

      t.timestamps
    end
  end
end
