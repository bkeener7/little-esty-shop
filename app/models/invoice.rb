class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  validates_presence_of :status, :customer_id

  enum status: { 'in progress' => 0, completed: 1, cancelled: 2 }

  def total_revenue
    (invoice_items.sum('unit_price * quantity') / 100.00).round(2)
  end

  def self.incomplete_invoices
    joins(:invoice_items)
      .where('invoice_items.status=0 OR invoice_items.status=1')
      .order(:created_at)
  end

  def total_discounted
    invoice_items
      .joins(:bulk_discounts)
      .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
      .select('MAX((invoice_items.unit_price *.01) * invoice_items.quantity * (bulk_discounts.percentage_discount * .001))')
      .sum(&:max)
      .round(2)
  end

  def revenue_with_discounts
    (total_revenue - total_discounted).round(2)
  end
end
