require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }

  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer) }
  let!(:customer3) { create(:customer) }
  let!(:customer4) { create(:customer) }
  let!(:customer5) { create(:customer) }

  let!(:invoice1) { create(:invoice, customer: customer1, created_at: Time.parse('19.07.18')) }
  let!(:invoice2) { create(:invoice, customer: customer2) }
  let!(:invoice3) { create(:invoice, customer: customer3) }
  let!(:invoice4) { create(:invoice, customer: customer4) }
  let!(:invoice5) { create(:invoice, customer: customer5) }

  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }
  let!(:item3) { create(:item, merchant: merchant2) }
  let!(:item4) { create(:item, merchant: merchant2) }

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, status: 'packaged') }
  let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice2, status: 'packaged') }
  let!(:invoice_item3) { create(:invoice_item, item: item3, invoice: invoice3, status: 'packaged') }
  let!(:invoice_item4) { create(:invoice_item, item: item4, invoice: invoice4, status: 'packaged') }
  let!(:invoice_item5) { create(:invoice_item, item: item2, invoice: invoice1, status: 'packaged') }

  let!(:transaction1) { create(:transaction, invoice: invoice1) }
  let!(:transaction2) { create(:transaction, invoice: invoice2) }
  let!(:transaction3) { create(:transaction, invoice: invoice3) }
  let!(:transaction4) { create(:transaction, invoice: invoice4) }

  let!(:bulk_discount1) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount2) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount3) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount4) { create(:bulk_discount, merchant: merchant2) }

  before :each do
    visit merchant_invoice_path(merchant1, invoice1)
  end

  describe 'As a merchant' do
    describe "When I visit my merchant's invoice show page" do
      it "Then I see information related to that invoice including: Invoice id, Invoice status, Invoice created_at date in the format 'Monday, July 18, 2019', Customer first and last name" do
        expect(page).to have_content("ID: #{invoice1.id}")
        expect(page).to have_content("Status: #{invoice1.status}")
        expect(page).to have_content('Created: Thursday, July 18, 2019')
        expect(page).to have_content("Customer: #{invoice1.customer.full_name}")
      end

      it 'Then I see all of my items on the invoice including: Item name, The quantity of the item ordered, The price the Item sold for, The Invoice Item status, And I do not see any information related to Items for other merchants' do
        within "#item-#{item2.id}" do
          expect(page).to have_content("Name: #{item2.name}")
          expect(page).to have_content("Price: #{item2.unit_price}")
          expect(page).to have_content("Quantity: #{item2.invoice_items.first.quantity}")
          expect(page).to have_content("Status: #{item2.invoice_items.first.status}")
        end

        within "#item-#{item1.id}" do
          expect(page).to have_content("Name: #{item1.name}")
          expect(page).to have_content("Price: #{item1.unit_price}")
          expect(page).to have_content("Quantity: #{item1.invoice_items.first.quantity}")
          expect(page).to have_content("Status: #{item1.invoice_items.first.status}")
        end

        expect(page).to_not have_content(item3.name)
      end

      it 'I see the total revenue that will be generated from all of my items on the invoice' do
        within '#total_invoice_revenue' do
          expect(page).to have_content("Total Invoice Revenue: #{invoice1.total_revenue}¢")
        end
      end

      it 'has a select field with current status that can be changed to update status' do
        within "#item-#{item1.id}" do
          expect(page).to have_selector(:css, 'form')
          expect(find('form')).to have_content("#{item1.invoice_items.first.status}")
          expect(item1.invoice_items.first.status).to eq('packaged')

          expect(page).to have_button('Update Item Status')

          select('shipped', from: 'Status')
          click_button('Update Item Status')

          expect(current_path).to eq(merchant_invoice_path(merchant1, invoice1))
          expect(item1.invoice_items.first.status).to eq('shipped')
          expect(find('form')).to have_content('shipped')
        end

        within("#item-#{item2.id}") do
          expect(page).to have_selector(:css, 'form')
          expect(find('form')).to have_content("#{item2.invoice_items.first.status}")
          expect(item2.invoice_items.first.status).to eq('packaged')

          expect(page).to have_button('Update Item Status')

          select('pending', from: 'Status')
          click_button('Update Item Status')

          expect(current_path).to eq(merchant_invoice_path(merchant1, invoice1))
          expect(item2.invoice_items.first.status).to eq('pending')
          expect(find('form')).to have_content('pending')

          select('packaged', from: 'Status')
          click_button('Update Item Status')

          expect(current_path).to eq(merchant_invoice_path(merchant1, invoice1))
          expect(item2.invoice_items.first.status).to eq('packaged')
          expect(find('form')).to have_content('packaged')
        end
      end
    end
  end
end
