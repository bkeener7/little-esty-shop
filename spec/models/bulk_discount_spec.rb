require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of :percentage_discount }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_numericality_of(:percentage_discount).is_greater_than(0) }
    it { should validate_numericality_of(:quantity_threshold).is_greater_than(0) }
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

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1) }
  let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice2) }
  let!(:invoice_item3) { create(:invoice_item, item: item3, invoice: invoice3) }
  let!(:invoice_item4) { create(:invoice_item, item: item4, invoice: invoice4) }

  let(:transaction1) { create(:transaction, invoice: invoice1) }
  let(:transaction2) { create(:transaction, invoice: invoice2) }
  let(:transaction3) { create(:transaction, invoice: invoice3) }
  let(:transaction4) { create(:transaction, invoice: invoice4) }

  let(:bulk_discount1) { create(:bulk_discount, merchant: merchant1) }
  let(:bulk_discount2) { create(:bulk_discount, merchant: merchant2) }

  describe 'class methods' do
    xit 'has a bulk discount' do
    end
  end
end
