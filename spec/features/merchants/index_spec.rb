require 'rails_helper'

RSpec.describe 'Merchants Dashboard Page' do
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

  before do
    visit merchant_dashboard_index_path(merchant1)
  end

  describe 'when I visit the merchant dashboard' do
    it 'sees the name of my merchant' do
      expect(current_path).to eq(merchant_dashboard_index_path(merchant1))
      expect(page).to have_content('Marvel')
      expect(page).to_not have_content('D.C.')
    end

    it 'sees a link to my merchant items index' do
      expect(page).to have_link('My Items')
      click_on('My Items')

      expect(current_path).to eq(merchant_items_path(merchant1))
    end

    it 'sees a link to my merchant invoices index' do
      expect(page).to have_link('My Invoices')
      click_on('My Invoices')

      expect(current_path).to eq(merchant_invoices_path(merchant1))
    end

    describe 'favorite customers' do
      it 'sees the names of the top 5 customers that conduct the largest number of successful transactions with merchants' do
        within('#top_customers') do
          expect(customer2.full_name).to appear_before(customer3.full_name)
          expect(customer3.full_name).to appear_before(customer1.full_name)
          expect(customer1.full_name).to appear_before(customer5.full_name)
          expect(customer5.full_name).to appear_before(customer6.full_name)
          expect(page).to have_content(customer6.full_name)
        end
      end

      it 'has the number of successful transactions with the merchant next to each customer' do
        within('#top_customers') do
          expect(page).to have_content("#{customer2.full_name} - Successful transactions: 3")
          expect(page).to have_content("#{customer3.full_name} - Successful transactions: 2")
          expect(page).to have_content("#{customer1.full_name} - Successful transactions: 1")
          expect(page).to have_content("#{customer5.full_name} - Successful transactions: 1")
          expect(page).to have_content("#{customer6.full_name} - Successful transactions: 1")
        end
      end
    end

    describe 'items ready to ship' do
      it 'has a section with list of names of items that have not yet shipped with a link to their merchant invoice show page' do
        within('#items_ready_to_ship') do
          expect(page).to have_content(item1.name)
          expect(page).to have_content(invoice1.id)
          expect(page).to have_content(invoice3.id)
          expect(page).to have_content(invoice4.id)
          expect(page).to have_content(invoice5.id)
          expect(page).to have_content(invoice6.id)
          expect(page).to_not have_content(invoice2.id)
          expect(page).to have_link(invoice1.id.to_s)
          expect(page).to have_link(invoice3.id.to_s)
          expect(page).to have_link(invoice4.id.to_s)
          expect(page).to have_link(invoice5.id.to_s)
          expect(page).to have_link(invoice6.id.to_s)
        end
        click_on(invoice1.id.to_s)

        expect(current_path).to eq(merchant_invoice_path(merchant1, invoice1))
      end

      it 'displays the invoices with items ready to ship ordered by creation date from oldest to newest' do
        within('#items_ready_to_ship') do
          invoices = [invoice1, invoice3, invoice4, invoice5, invoice6]
          invoices.sort_by!(&:created_at)

          # Collect all invoice ids and dates from the page
          page_invoices = page.all('li').map do |li|
            id, date_string = li.text.scan(/(\d+) - Invoice Date: ([\w\s,]+)/).first
            [id.to_i, Date.parse(date_string)]
          end

          # Compare with our invoices
          invoices.each_with_index do |invoice, index|
            expect(page_invoices[index]).to eq [invoice.id, invoice.created_at.to_date]
          end
        end
      end

      describe 'merchant discounts' do
        it 'has a link to view all my discounts' do
          within '#discounts' do
            expect(page).to have_link('Current Discounts')

            click_on('Current Discounts')
          end

          expect(current_path).to eq(merchant_discounts_path(merchant1))
        end
      end
    end
  end
end
