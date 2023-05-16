require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:merchant1) { Merchant.create!(name: 'Marvel') }
  let(:merchant2) { Merchant.create!(name: 'D.C.') }
  let(:customer1) { Customer.create!(first_name: 'Peter', last_name: 'Parker') }
  let(:customer2) { Customer.create!(first_name: 'Clark', last_name: 'Kent') }
  let(:customer3) { Customer.create!(first_name: 'Louis', last_name: 'Lane') }
  let(:customer4) { Customer.create!(first_name: 'Lex', last_name: 'Luther') }
  let(:customer5) { Customer.create!(first_name: 'Frank', last_name: 'Castle') }
  let(:customer6) { Customer.create!(first_name: 'Matt', last_name: 'Murdock') }
  let(:customer7) { Customer.create!(first_name: 'Bruce', last_name: 'Wayne') }
  let(:invoice1) { Invoice.create!(status: 'completed', customer_id: customer1.id) }
  let(:invoice2) { Invoice.create!(status: 'completed', customer_id: customer2.id) }
  let(:invoice3) { Invoice.create!(status: 'completed', customer_id: customer3.id) }
  let(:invoice4) { Invoice.create!(status: 'cancelled', customer_id: customer4.id) }
  let(:invoice5) { Invoice.create!(status: 'completed', customer_id: customer5.id) }
  let(:invoice6) { Invoice.create!(status: 'completed', customer_id: customer6.id) }
  let(:invoice7) { Invoice.create!(status: 'completed', customer_id: customer7.id) }
  let(:invoice8) { Invoice.create!(status: 'completed', customer_id: customer1.id) }
  let(:invoice9) { Invoice.create!(status: 'completed', customer_id: customer2.id) }
  let(:invoice10) { Invoice.create!(status: 'completed', customer_id: customer2.id) }
  let(:invoice11) { Invoice.create!(status: 'completed', customer_id: customer3.id) }
  let(:item1) { Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: merchant1.id) }
  let(:item2) { Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: merchant2.id) }
  let!(:invoice_item1) { InvoiceItem.create!(quantity: 5, unit_price: 500, status: 'packaged', item_id: item1.id, invoice_id: invoice1.id) }
  let!(:invoice_item2) { InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: item1.id, invoice_id: invoice2.id) }
  let!(:invoice_item3) { InvoiceItem.create!(quantity: 6, unit_price: 600, status: 'pending', item_id: item1.id, invoice_id: invoice3.id) }
  let!(:invoice_item4) { InvoiceItem.create!(quantity: 12, unit_price: 1200, status: 'packaged', item_id: item1.id, invoice_id: invoice4.id) }
  let!(:invoice_item5) { InvoiceItem.create!(quantity: 8, unit_price: 800, status: 'packaged', item_id: item1.id, invoice_id: invoice5.id) }
  let!(:invoice_item6) { InvoiceItem.create!(quantity: 20, unit_price: 2000, status: 'packaged', item_id: item1.id, invoice_id: invoice6.id) }
  let!(:invoice_item7) { InvoiceItem.create!(quantity: 50, unit_price: 5000, status: 'shipped', item_id: item2.id, invoice_id: invoice7.id) }
  let!(:invoice_item8) { InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: item2.id, invoice_id: invoice8.id) }
  let!(:invoice_item9) { InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: item1.id, invoice_id: invoice9.id) }
  let!(:invoice_item10) { InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: item1.id, invoice_id: invoice10.id) }
  let!(:invoice_item11) { InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: item1.id, invoice_id: invoice11.id) }
  let!(:transaction1) { Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil, result: 'failed', invoice_id: invoice1.id) }
  let!(:transaction2) { Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil, result: 'success', invoice_id: invoice1.id) }
  let!(:transaction3) { Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil, result: 'success', invoice_id: invoice2.id) }
  let!(:transaction4) { Transaction.create!(credit_card_number: '4923661117104166', credit_card_expiration_date: nil, result: 'success', invoice_id: invoice3.id) }
  let!(:transaction5) { Transaction.create!(credit_card_number: '4536896899874279', credit_card_expiration_date: nil, result: 'failed', invoice_id: invoice4.id) }
  let!(:transaction6) { Transaction.create!(credit_card_number: '4536896899874280', credit_card_expiration_date: nil, result: 'failed', invoice_id: invoice4.id) }
  let!(:transaction7) { Transaction.create!(credit_card_number: '4536896899874281', credit_card_expiration_date: nil, result: 'success', invoice_id: invoice5.id) }
  let!(:transaction8) { Transaction.create!(credit_card_number: '4536896899874286', credit_card_expiration_date: nil, result: 'failed', invoice_id: invoice6.id) }
  let!(:transaction9) { Transaction.create!(credit_card_number: '4636896899874290', credit_card_expiration_date: nil, result: 'success', invoice_id: invoice6.id) }
  let!(:transaction10) { Transaction.create!(credit_card_number: '4636896899874291', credit_card_expiration_date: nil, result: 'success', invoice_id: invoice7.id) }
  let!(:transaction11) { Transaction.create!(credit_card_number: '4636896899874298', credit_card_expiration_date: nil, result: 'success', invoice_id: invoice8.id) }
  let!(:transaction12) { Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil, result: 'success', invoice_id: invoice9.id) }
  let!(:transaction13) { Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil, result: 'success', invoice_id: invoice10.id) }
  let!(:transaction14) { Transaction.create!(credit_card_number: '4636896899845752', credit_card_expiration_date: nil, result: 'success', invoice_id: invoice11.id) }

  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:merchants).through(:invoices) }
    it { should have_many(:items).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'class methods' do
    it 'can display the first and last name together' do
      expect(customer7.full_name).to eq('Bruce Wayne')
    end

    describe 'on admin dashboard, we see top 5 customers' do
      it 'displays top 5 customers' do
        expect(Customer.top_customers).to eq([customer2, customer1, customer3, customer5, customer6])
      end
    end
  end
end
