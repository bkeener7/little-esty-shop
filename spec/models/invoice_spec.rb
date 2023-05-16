require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:customer_id) }
  end

  describe 'class methods' do
    describe '#incomplete_invoices' do
      it 'returns all invoices that have items that have not been shipped' do
        customer_1 = create(:customer)
        create(:merchant)
        invoice_1 = create(:invoice, customer: customer_1, status: 1)
        invoice_2 = create(:invoice, customer: customer_1, status: 1)
        invoice_3 = create(:invoice, customer: customer_1, status: 1)
        invoice_4 = create(:invoice, customer: customer_1, status: 1)
        invoice_5 = create(:invoice, customer: customer_1, status: 1)
        create(:invoice, customer: customer_1, status: 1)
        create(:invoice, customer: customer_1, status: 1)
        create(:invoice, customer: customer_1, status: 1)
        create(:invoice_item, invoice: invoice_1, status: 1)
        create(:invoice_item, invoice: invoice_2, status: 2)
        create(:invoice_item, invoice: invoice_3, status: 1)
        create(:invoice_item, invoice: invoice_4, status: 1)
        create(:invoice_item, invoice: invoice_5, status: 0)

        expect(Invoice.incomplete_invoices).to eq([invoice_1, invoice_3, invoice_4, invoice_5])
      end
    end
  end

  describe 'instance methods' do
    describe '#total_revenue' do
      it 'totals revenue from all invoice items' do
        customer_1 = create(:customer)
        merchant = create(:merchant)
        item_1 = create(:item, unit_price: 10, merchant: merchant)
        item_2 = create(:item, unit_price: 10, merchant: merchant)
        invoice_1 = create(:invoice, customer: customer_1, status: 1)
        create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 9, unit_price: 10)
        create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 9, unit_price: 10)

        expect(invoice_1.total_revenue).to eq(1.80)
      end
    end

    describe '#total_discounted' do
      it 'finds the total discount amount applied to invoice items' do
        customer_1 = create(:customer)
        merchant = create(:merchant)
        create(:bulk_discount, percentage_discount: 10, quantity_threshold: 100, merchant: merchant)
        create(:bulk_discount, percentage_discount: 8, quantity_threshold: 100, merchant: merchant)
        create(:bulk_discount, percentage_discount: 50, quantity_threshold: 1000, merchant: merchant)
        item_1 = create(:item, unit_price: 500, merchant: merchant)
        item_2 = create(:item, unit_price: 980, merchant: merchant)
        invoice_1 = create(:invoice, customer: customer_1, status: 1)
        create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 9, unit_price: 500)
        create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 138, unit_price: 980)
        expect(invoice_1.total_discounted).to eq(13.52)
      end
    end

    describe '#revenue_with_discounts' do
      it 'finds the total revenue after applying discounts to invoice items' do
        customer_1 = create(:customer)
        merchant = create(:merchant)
        create(:bulk_discount, percentage_discount: 10, quantity_threshold: 100, merchant: merchant)
        create(:bulk_discount, percentage_discount: 8, quantity_threshold: 100, merchant: merchant)
        create(:bulk_discount, percentage_discount: 50, quantity_threshold: 1000, merchant: merchant)
        item_1 = create(:item, unit_price: 500, merchant: merchant)
        item_2 = create(:item, unit_price: 980, merchant: merchant)
        invoice_1 = create(:invoice, customer: customer_1, status: 1)
        create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 9, unit_price: 500)
        create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 138, unit_price: 980)

        expect(invoice_1.revenue_with_discounts).to eq(1383.88)
      end
    end
  end
end
