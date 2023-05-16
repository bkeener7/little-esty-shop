class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates :status, :customer_id, presence: true

  enum status: { 'in progress' => 0, completed: 1, cancelled: 2 }

  scope :incomplete_invoices, -> {
    joins(:invoice_items)
      .where('invoice_items.status' => [statuses['in progress'], statuses['completed']])
      .order(:created_at)
  }

  def total_revenue
    raw_total_revenue.round(2)
  end

  def total_discounted
    raw_total_discounted.round(2)
  end

  def revenue_with_discounts
    (raw_total_revenue - raw_total_discounted).round(2)
  end

  private

  def raw_total_revenue
    (invoice_items.sum('unit_price * quantity') / 100.00)
  end

  def raw_total_discounted
    invoice_items
      .joins(:bulk_discounts)
      .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
      .select('MAX((invoice_items.unit_price * 0.01) * invoice_items.quantity * (bulk_discounts.percentage_discount * 0.001))')
      .sum(&:max)
  end
end
