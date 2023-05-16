require 'rails_helper'

RSpec.describe 'Merchant Invoices Index page', type: :feature do
  let(:merchant) { create(:merchant, name: 'Marvel') }
  let(:customer) { create(:customer, first_name: 'Peter', last_name: 'Parker') }
  let(:item1) { create(:item, name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant: merchant) }
  let(:item2) { create(:item, name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 100, merchant: merchant) }
  let(:invoice1) { create(:invoice, status: 'completed', customer: customer) }

  before do
    create(:invoice_item, quantity: 5, unit_price: 500, status: 'packaged', item: item1, invoice: invoice1)
    create(:invoice_item, quantity: 15, unit_price: 1500, status: 'packaged', item: item2, invoice: invoice1)
  end

  describe 'As a merchant' do
    describe "When I visit my merchant's invoices index" do
      it "displays all the invoices that include at least one of my merchant's items" do
        visit merchant_invoices_path(merchant)

        expect(page).to have_content('Invoices:')
        expect(merchant.invoices.count).to eq(1)
      end

      it 'displays the id of each invoice' do
        visit merchant_invoices_path(merchant)

        within('#invoice_ids') do
          expect(page).to have_content("Invoice: #{invoice1.id}")
        end
      end

      it 'links each invoice id to the merchant invoice show page' do
        visit merchant_invoices_path(merchant)

        within('#invoice_ids') do
          expect(page).to have_link("#{invoice1.id}")

          click_link("#{invoice1.id}")

          expect(current_path).to eq(merchant_invoice_path(merchant, invoice1))
        end
      end
    end
  end
end
