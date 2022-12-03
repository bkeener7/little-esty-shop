class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :percentage_discount, :quantity_threshold, presence: true
  validates :percentage_discount, numericality: { greater_than: 0 }
  validates :quantity_threshold, numericality: { greater_than: 0 }
end
