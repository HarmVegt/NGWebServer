class CreateDeliverers < ActiveRecord::Migration[5.2]
  def change
    create_table :deliverers do |t|
      t.string :firstname
      t.string :lastname
      t.string :preposition

      t.timestamps
    end
  end
end
