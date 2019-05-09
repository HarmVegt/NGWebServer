class RemoveAddressRefFromCustomer < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :address_id
  end
end
