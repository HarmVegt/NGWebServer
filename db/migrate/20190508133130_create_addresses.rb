class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :zipcode
      t.integer :housenumber
      t.string :city
      t.string :annex
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
