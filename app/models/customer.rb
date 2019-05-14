class Customer < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :retours, dependent: :destroy
end
