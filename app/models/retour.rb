class Retour < ApplicationRecord
  belongs_to :customer
  has_many :retour_lines, dependent: :destroy
end
