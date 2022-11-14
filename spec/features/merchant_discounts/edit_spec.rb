require 'rails_helper'

RSpec.describe 'bulk discounts edit page' do
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
    visit edit_merchant_discount_path(merchant1, bulk_discount1)
  end

  describe 'when I visit my bulk discounts show page' do
    it 'goes to the bulk discounts show page' do
      expect(current_path).to eq(edit_merchant_discount_path(merchant1, bulk_discount1))
    end

    it 'has a form with current discounts pre-populated' do
      within '#edit_form' do
        expect(page).to have_selector(:css, 'form')
        expect(page).to have_content('Percentage Discount:')
        expect(page).to have_field(:percentage_discount, with: bulk_discount1.percentage_discount)
        expect(page).to have_content('Quantity Threshold:')
        expect(page).to have_field(:quantity_threshold, with: bulk_discount1.quantity_threshold)
        expect(page).to have_button('Update Discount')
      end
    end

    it 'allows you to update both fields and takes you back to the show page with attributes updated' do
      within '#edit_form' do
        fill_in :percentage_discount, with: 20
        fill_in :quantity_threshold, with: 20
        click_button('Update Discount')
      end

      expect(current_path).to eq(merchant_discount_path(merchant1, bulk_discount1))

      within '#discount_details' do
        expect(page).to have_content('Percentage Discount: 20%')
        expect(page).to have_content('Quantity Threshold: 20')
      end
    end

    it 'allows you to update both fields and takes you back to the show page with attributes updated' do
      within '#edit_form' do
        fill_in :percentage_discount, with: 20
        fill_in :quantity_threshold, with: 20
        click_button('Update Discount')
      end

      expect(current_path).to eq(merchant_discount_path(merchant1, bulk_discount1))

      within '#discount_details' do
        expect(page).to have_content('Percentage Discount: 20%')
        expect(page).to have_content('Quantity Threshold: 20')
      end
    end

    it 'allows you to update one field and takes you back to the show page with attributes updated' do
      within '#edit_form' do
        fill_in :percentage_discount, with: 20
        click_button('Update Discount')
      end

      expect(current_path).to eq(merchant_discount_path(merchant1, bulk_discount1))

      within '#discount_details' do
        expect(page).to have_content('Percentage Discount: 20%')
        expect(page).to have_content("Quantity Threshold: #{bulk_discount1.quantity_threshold}")
      end
    end

    it 'returns an error if content is missing from the form and redirects back to edit page' do
      within '#edit_form' do
        fill_in :percentage_discount, with: ''
        fill_in :quantity_threshold, with: 20
        click_button('Update Discount')
      end

      expect(current_path).to eq(edit_merchant_discount_path(merchant1, bulk_discount1))
      expect(page).to have_content('Required content missing or invalid')

      within '#edit_form' do
        expect(page).to have_field(:percentage_discount, with: bulk_discount1.percentage_discount)
        expect(page).to have_field(:quantity_threshold, with: bulk_discount1.quantity_threshold)
      end
    end
  end
end
