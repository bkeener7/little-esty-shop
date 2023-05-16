require 'rails_helper'

RSpec.describe 'Bulk Discounts Edit Page' do
  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }

  let!(:bulk_discount1) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount2) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount3) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount4) { create(:bulk_discount, merchant: merchant2) }

  before :each do
    visit edit_merchant_discount_path(merchant1, bulk_discount1)
  end

  describe 'When I visit the bulk discount edit page' do
    it 'displays the form with current discounts pre-populated' do
      within '#edit_form' do
        expect(page).to have_selector('form')
        expect(page).to have_content('Percentage Discount:')
        expect(page).to have_field(:percentage_discount, with: bulk_discount1.percentage_discount)
        expect(page).to have_content('Quantity Threshold:')
        expect(page).to have_field(:quantity_threshold, with: bulk_discount1.quantity_threshold)
        expect(page).to have_button('Update Discount')
      end
    end

    it 'updates both fields and redirects to the show page with updated attributes' do
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

    it 'updates one field and redirects to the show page with updated attributes' do
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

    it 'returns an error if content is missing from the form and redirects back to the edit page' do
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
