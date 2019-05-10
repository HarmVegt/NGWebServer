class AddStreetToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :street, :string, after: :housenumber
  end
end
