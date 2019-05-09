class CreateRetourLines < ActiveRecord::Migration[5.2]
  def change
    create_table :retour_lines do |t|
      t.references :retour, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
