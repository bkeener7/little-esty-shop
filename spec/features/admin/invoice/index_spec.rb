require 'rails_helper'

RSpec.describe 'admin/invoices' do
  let!(:customer_1) { create(:customer, first_name: 'Eli', last_name: 'Fuchsman') }
  let!(:customer_2) { create(:customer, first_name: 'Bryan', last_name: 'Keener') }
  let!(:customer_3) { create(:customer, first_name: 'Darby', last_name: 'Smith') }
  let!(:customer_4) { create(:customer, first_name: 'James', last_name: 'White') }
  let!(:customer_5) { create(:customer, first_name: 'William', last_name: 'Lampke') }
  let!(:customer_6) { create(:customer, first_name: 'Abdul', last_name: 'Redd') }

  let!(:merchant) { create(:merchant, name: 'Test') }

  let!(:item_1) { create(:item, name: 'item1', description: 'desc1', unit_price: 10, merchant: merchant) }

  let!(:invoice_1) { create(:invoice, customer: customer_1, status: 1) }
  let!(:invoice_2) { create(:invoice, customer: customer_2, status: 1) }
  let!(:invoice_3) { create(:invoice, customer: customer_3, status: 1) }
  let!(:invoice_4) { create(:invoice, customer: customer_4, status: 1) }
  let!(:invoice_5) { create(:invoice, customer: customer_5, status: 1) }
  let!(:invoice_6) { create(:invoice, customer: customer_2, status: 1) }
  let!(:invoice_7) { create(:invoice, customer: customer_2, status: 1) }
  let!(:invoice_8) { create(:invoice, customer: customer_4, status: 1) }

  it 'shows all invoice ids in the system and links to a show page' do
    visit 'admin/invoices'

    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_2.id)
    expect(page).to have_content(invoice_3.id)
    expect(page).to have_content(invoice_4.id)
    expect(page).to have_content(invoice_5.id)
    expect(page).to have_content(invoice_6.id)
    expect(page).to have_content(invoice_7.id)
    expect(page).to have_content(invoice_8.id)
  end
end
