require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page', type: :feature do
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

  let!(:bulk_discount1) { create(:bulk_discount, merchant: merchant1, percentage_discount: 100, quantity_threshold: 1) }
  let!(:bulk_discount2) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount3) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount4) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount5) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount6) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount7) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount8) { create(:bulk_discount, merchant: merchant2) }

  before :each do
    visit merchant_invoice_path(merchant1, invoice1)
  end

  describe 'As a merchant' do
    describe "When I visit my merchant's invoice show page" do
      it 'displays information related to that invoice' do
        expect(page).to have_content("ID: #{invoice1.id}")
        expect(page).to have_content("Status: #{invoice1.status}")
        expect(page).to have_content('Created: Thursday, July 18, 2019')
        expect(page).to have_content("Customer: #{invoice1.customer.full_name}")
      end

      it 'displays all items on the invoice' do
        within "#item-#{item2.id}" do
          expect(page).to have_content("Name: #{item2.name}")
          expect(page).to have_content("Price: $#{item2.unit_price_dollars}")
          expect(page).to have_content("Quantity: #{item2.invoice_items.first.quantity}")
          expect(page).to have_content("Status: #{item2.invoice_items.first.status}")
        end

        within "#item-#{item1.id}" do
          expect(page).to have_content("Name: #{item1.name}")
          expect(page).to have_content("Price: $#{item1.unit_price_dollars}")
          expect(page).to have_content("Quantity: #{item1.invoice_items.first.quantity}")
          expect(page).to have_content("Status: #{item1.invoice_items.first.status}")
        end

        expect(page).not_to have_content(item3.name)
      end

      it 'displays the total revenue generated from all items on the invoice' do
        within '#total_invoice_revenue' do
          expect(page).to have_content("Total Invoice Revenue: $#{invoice1.total_revenue}")
        end
      end

      it 'allows updating the status of items' do
        within "#item-#{item1.id}" do
          expect(page).to have_selector('form')
          expect(find('form')).to have_content("#{item1.invoice_items.first.status}")
          expect(item1.invoice_items.first.status).to eq('packaged')

          expect(page).to have_button('Update Item Status')

          select('shipped', from: 'Status')
          click_button('Update Item Status')

          expect(current_path).to eq(merchant_invoice_path(merchant1, invoice1))
          expect(item1.invoice_items.first.status).to eq('shipped')
          expect(find('form')).to have_content('shipped')
        end

        within "#item-#{item2.id}" do
          expect(page).to have_selector('form')
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

      it 'displays total discounted revenue for the merchant from this invoice' do
        within '#total_discounts' do
          expect(page).to have_content("Total Discounts: $#{invoice1.total_discounted}")
        end
        within '#total_discounted_revenue' do
          expect(page).to have_content("Total Discounted Invoice Revenue: $#{invoice1.revenue_with_discounts}")
        end
      end

      it 'has a link next to each invoice item to see applied discounts' do
        within "#item-#{item1.id}" do
          expect(page).to have_link("Discount ##{bulk_discount1.id}")
          click_link("Discount ##{bulk_discount1.id}")
        end
        expect(current_path).to eq(merchant_discount_path(merchant1, bulk_discount1))
      end
    end
  end
end
