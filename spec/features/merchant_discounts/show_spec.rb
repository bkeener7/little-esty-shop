require 'rails_helper'

RSpec.describe 'bulk discounts show page' do
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

  let!(:transaction1) { create(:transaction, invoice: invoice1) }
  let!(:transaction2) { create(:transaction, invoice: invoice2) }
  let!(:transaction3) { create(:transaction, invoice: invoice3) }
  let!(:transaction4) { create(:transaction, invoice: invoice4) }

  let!(:bulk_discount1) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount2) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount3) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount4) { create(:bulk_discount, merchant: merchant2) }

  before :each do
    visit merchant_discount_path(merchant1, bulk_discount1)
  end

  describe 'when I visit my bulk discounts show page' do
    it 'goes to the bulk discounts show page' do
      expect(current_path).to eq(merchant_discount_path(merchant1, bulk_discount1))
    end
    
    it 'has the bulk discounts quantity threshold and percentage discount' do
      within '#discount_details' do
        expect(page).to have_content("Percentage Discount: #{bulk_discount1.percentage_discount}%")
        expect(page).to have_content("Quantity Threshold: #{bulk_discount1.quantity_threshold}")
        expect(page).to_not have_content(bulk_discount2.percentage_discount)
        expect(page).to_not have_content(bulk_discount2.quantity_threshold)
      end
    end
  end
end
