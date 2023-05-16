require 'rails_helper'

RSpec.describe 'Admin Index' do
  let!(:customer_1) { create(:customer, first_name: 'Eli', last_name: 'Fuchsman') }
  let!(:customer_2) { create(:customer, first_name: 'Bryan', last_name: 'Keener') }
  let!(:customer_3) { create(:customer, first_name: 'Darby', last_name: 'Smith') }
  let!(:customer_4) { create(:customer, first_name: 'James', last_name: 'White') }
  let!(:customer_5) { create(:customer, first_name: 'William', last_name: 'Lampke') }
  let!(:customer_6) { create(:customer, first_name: 'Abdul', last_name: 'Redd') }

  let!(:merchant) { create(:merchant, name: 'Test') }

  let!(:item_1) { create(:item, name: 'item1', description: 'desc1', unit_price: 10, merchant: merchant) }

  let!(:invoice_1) { create(:invoice, customer: customer_1, status: 1, created_at: Time.parse('22.10.30')) }
  let!(:invoice_2) { create(:invoice, customer: customer_2, status: 1, created_at: Time.parse('22.10.31')) }
  let!(:invoice_3) { create(:invoice, customer: customer_3, status: 1, created_at: Time.parse('22.10.15')) }
  let!(:invoice_4) { create(:invoice, customer: customer_4, status: 1, created_at: Time.parse('22.11.01')) }
  let!(:invoice_5) { create(:invoice, customer: customer_5, status: 1, created_at: Time.parse('22.11.02')) }
  let!(:invoice_6) { create(:invoice, customer: customer_2, status: 1, created_at: Time.parse('22.11.03')) }
  let!(:invoice_7) { create(:invoice, customer: customer_2, status: 1, created_at: Time.parse('22.10.12')) }
  let!(:invoice_8) { create(:invoice, customer: customer_4, status: 1, created_at: Time.parse('22.10.19')) }

  let!(:ii_1) { create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 9, unit_price: 10, status: 1) }
  let!(:ii_2) { create(:invoice_item, invoice: invoice_2, item: item_1, quantity: 1, unit_price: 10, status: 2) }
  let!(:ii_3) { create(:invoice_item, invoice: invoice_3, item: item_1, quantity: 2, unit_price: 10, status: 1) }
  let!(:ii_4) { create(:invoice_item, invoice: invoice_4, item: item_1, quantity: 3, unit_price: 10, status: 1) }
  let!(:ii_5) { create(:invoice_item, invoice: invoice_5, item: item_1, quantity: 1, unit_price: 10, status: 0) }

  let!(:transaction_1) { create(:transaction, credit_card_number: '1', result: 0, invoice: invoice_1) }
  let!(:transaction_2) { create(:transaction, credit_card_number: '2', result: 0, invoice: invoice_2) }
  let!(:transaction_3) { create(:transaction, credit_card_number: '3', result: 0, invoice: invoice_3) }
  let!(:transaction_4) { create(:transaction, credit_card_number: '4', result: 0, invoice: invoice_4) }
  let!(:transaction_5) { create(:transaction, credit_card_number: '5', result: 0, invoice: invoice_5) }
  let!(:transaction_6) { create(:transaction, credit_card_number: '5', result: 0, invoice: invoice_6) }
  let!(:transaction_7) { create(:transaction, credit_card_number: '5', result: 0, invoice: invoice_7) }
  let!(:transaction_8) { create(:transaction, credit_card_number: '5', result: 0, invoice: invoice_8) }

  before do
    visit admin_index_path
  end

  it 'displays a header indicating the user is on the Admin Dashboard' do
    expect(page).to have_content('Admin')
  end

  it 'has a link to Admin/Merchants' do
    expect(page).to have_link('Merchants', href: admin_merchants_path)
  end

  it 'has a link to Admin/Invoices' do
    expect(page).to have_link('Invoices', href: admin_invoices_path)
  end

  describe 'top 5 customers section' do
    it 'displays the top 5 customers' do
      expect(page).to have_content('Eli Fuchsman: 1')
      expect(page).to have_content('Darby Smith: 1')
      expect(page).to have_content('William Lampke: 1')
      expect(page).to have_content('Bryan Keener: 3')
      expect(page).to have_content('James White: 2')
      expect('Bryan Keener: 3').to appear_before('James White: 2')
      expect('James White: 2').to appear_before('Eli Fuchsman: 1')
      expect('Eli Fuchsman: 1').to appear_before('Darby Smith: 1')
      expect('Darby Smith: 1').to appear_before('William Lampke: 1')
    end
  end

  describe 'incomplete invoices section' do
    it 'displays the IDs of invoices for items that have not been shipped' do
      within('#incomplete_invoices') do
        expect(page).to have_link(invoice_3.id.to_s)
        expect(page).to have_link(invoice_1.id.to_s)
        expect(page).to have_link(invoice_4.id.to_s)
        expect(page).to have_link(invoice_5.id.to_s)
        expect(page).not_to have_link(invoice_2.id.to_s)
      end
    end

    it 'orders invoices from oldest to newest by creation date' do
      within('#incomplete_invoices') do
        expect(invoice_3.id.to_s).to appear_before(invoice_1.id.to_s)
        expect(invoice_1.id.to_s).to appear_before(invoice_4.id.to_s)
        expect(invoice_4.id.to_s).to appear_before(invoice_5.id.to_s)
      end
    end

    it 'shows the creation date for incomplete invoices in a Day, Month Date, Year format' do
      expect(page).to have_content('Saturday, October 15, 2022')
      expect(page).to have_content('Sunday, October 30, 2022')
      expect(page).to have_content('Tuesday, November 1, 2022')
      expect(page).to have_content('Wednesday, November 2, 2022')
    end
  end
end
