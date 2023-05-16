require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price).is_greater_than(0) }
    it { should validate_presence_of(:merchant_id) }
  end

  describe 'Instance Methods' do
    let(:merchant1) { create(:merchant, name: 'Marvel') }
    let(:customer1) { create(:customer, first_name: 'Peter', last_name: 'Parker') }
    let(:customer3) { create(:customer, first_name: 'Louis', last_name: 'Lane') }
    let(:customer6) { create(:customer, first_name: 'Matt', last_name: 'Murdock') }
    let(:item1) { create(:item, name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant: merchant1) }
    let!(:invoice1) { create(:invoice, status: 'completed', customer: customer1, created_at: '2009-05-01 01:31:45') }
    let!(:invoice3) { create(:invoice, status: 'completed', customer: customer3, created_at: '2009-07-03 01:22:45') }
    let!(:invoice6) { create(:invoice, status: 'completed', customer: customer6, created_at: '2009-10-06 01:59:45') }

    before :each do
      create(:invoice_item, quantity: 5, unit_price: 100, status: 'packaged', item: item1, invoice: invoice1)
      create(:invoice_item, quantity: 6, unit_price: 100, status: 'pending', item: item1, invoice: invoice3)
      create(:invoice_item, quantity: 20, unit_price: 100, status: 'packaged', item: item1, invoice: invoice6)
    end

    describe '#top_item_selling_date' do
      it 'returns the day an item sold the most quantity' do
        expect(item1.top_item_selling_date).to eq('2009-10-06 01:59:45')
      end
    end

    describe '#unit_price_dollars' do
      it 'converts unit price to dollars' do
        expect(item1.unit_price_dollars).to eq(1.00)
      end
    end
  end
end
