class Bill < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  has_many :bill_items, dependent: :destroy

  accepts_nested_attributes_for :bill_items, allow_destroy: true
end