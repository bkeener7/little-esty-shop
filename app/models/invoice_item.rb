class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  validates :quantity, :unit_price, :status, :item_id, :invoice_id, presence: true

  enum status: { pending: 0, packaged: 1, shipped: 2 }

  def discount_applied
    bulk_discounts
      .where('bulk_discounts.quantity_threshold <= ?', quantity)
      .order('bulk_discounts.percentage_discount desc')
      .first
  end
end
