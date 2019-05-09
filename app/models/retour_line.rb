class RetourLine < ApplicationRecord
  belongs_to :retour
  belongs_to :product
end
