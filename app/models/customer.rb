class Customer < ApplicationRecord

  #attr_accessor :authKey

  has_one :address, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_lines, through: :orders
  has_many :retours, dependent: :destroy
end
