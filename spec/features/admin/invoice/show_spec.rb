require 'rails_helper'

RSpec.describe 'admin/invoices/invoice.id' do
  let!(:customer_1) { create(:customer, first_name: 'Eli', last_name: 'Fuchsman') }
  let!(:merchant) { create(:merchant, name: 'Test') }
  let!(:discount1) { create(:bulk_discount, percentage_discount: 50, quantity_threshold: 10, merchant: merchant) }
  let!(:item_1) { create(:item, name: 'item1', description: 'desc1', unit_price: 10, merchant: merchant) }
  let!(:item_2) { create(:item, name: 'item2', description: 'desc2', unit_price: 12, merchant: merchant) }
  let!(:invoice_1) { create(:invoice, customer: customer_1, status: 1, created_at: Time.parse('22.10.12')) }
  let!(:ii_1) { create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 9, unit_price: 10, status: 1) }
  let!(:ii_2) { create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 11, unit_price: 12, status: 1) }
  let!(:transaction_1) { create(:transaction, credit_card_number: '1', result: 0, invoice: invoice_1) }
  let!(:transaction_2) { create(:transaction, credit_card_number: '1', result: 0, invoice: invoice_1) }

  describe 'invoice show, has invoice info, invoice items info, and total revenue' do
    it 'shows related information to a specific invoice' do
      visit admin_invoice_path(invoice_1)

      expect(page).to have_content("Id: #{invoice_1.id}")
      expect(page).to have_content('Status: completed')
      expect(page).to have_content('Created at: Wednesday, October 12, 2022')
      expect(page).to have_content('Customer Name: Eli Fuchsman')
    end

    it 'shows all items on the invoice including item name, quantity, price, status' do
      visit admin_invoice_path(invoice_1)

      expect(page).to have_content('Invoice Items:')
      expect(page).to have_content('Item Name: item1')
      expect(page).to have_content('Unit Price: 10')
      expect(page).to have_content('Quantity: 9')
      expect(page).to have_content('Status: packaged')

      expect(page).to have_content('Item Name: item2')
      expect(page).to have_content('Unit Price: 12')
      expect(page).to have_content('Quantity: 11')
      expect(page).to have_content('Status: packaged')
    end

    it 'shows the total revenue that will be generated from this invoice' do
      visit admin_invoice_path(invoice_1)

      expect(page).to have_content("Total Invoice Revenue: $#{invoice_1.total_revenue}")
    end

    it 'can update invoice status from a select field' do
      visit admin_invoice_path(invoice_1)
      choose(:status, option: 'in progress')
      click_on 'Update Invoice Status'
      expect(page).to have_content('Status: in progress')
    end

    it 'shows discounted revenue' do
      visit admin_invoice_path(invoice_1)

      within '#total_discounts' do
        expect(page).to have_content("Total Discounts: $#{invoice_1.total_discounted}")
      end

      within '#total_discounted_revenue' do
        expect(page).to have_content("Total Discounted Invoice Revenue: $#{invoice_1.revenue_with_discounts}")
      end
    end
  end
end
