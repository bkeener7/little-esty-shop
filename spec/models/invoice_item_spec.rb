require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_one(:merchant) }
    it { should have_many(:bulk_discounts).through(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
  end

  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }

  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer) }
  let!(:customer3) { create(:customer) }
  let!(:customer4) { create(:customer) }
  let!(:customer5) { create(:customer) }

  let!(:invoice1) { create(:invoice, customer: customer1) }
  let!(:invoice2) { create(:invoice, customer: customer2) }
  let!(:invoice3) { create(:invoice, customer: customer3) }
  let!(:invoice4) { create(:invoice, customer: customer4) }
  let!(:invoice5) { create(:invoice, customer: customer5) }

  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }
  let!(:item3) { create(:item, merchant: merchant2) }
  let!(:item4) { create(:item, merchant: merchant2) }

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, quantity: 100) }
  let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice2) }
  let!(:invoice_item3) { create(:invoice_item, item: item3, invoice: invoice3) }
  let!(:invoice_item4) { create(:invoice_item, item: item4, invoice: invoice4) }
  let!(:invoice_item5) { create(:invoice_item, item: item2, invoice: invoice1) }

  let!(:transaction1) { create(:transaction, invoice: invoice1) }
  let!(:transaction2) { create(:transaction, invoice: invoice2) }
  let!(:transaction3) { create(:transaction, invoice: invoice3) }
  let!(:transaction4) { create(:transaction, invoice: invoice4) }

  let!(:bulk_discount1) { create(:bulk_discount, merchant: merchant1, quantity_threshold: 99, percentage_discount: 50) }
  let!(:bulk_discount2) { create(:bulk_discount, merchant: merchant1, quantity_threshold: 100, percentage_discount: 60) }
  let!(:bulk_discount3) { create(:bulk_discount, merchant: merchant1, quantity_threshold: 100, percentage_discount: 49) }
  let!(:bulk_discount4) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount5) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount6) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount7) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount8) { create(:bulk_discount, merchant: merchant2) }

  describe '#instance methods' do
    it 'can return the discount applied to an invoice item' do
      expect(invoice_item1.discount_applied).to eq(bulk_discount2)
    end
  end
end
