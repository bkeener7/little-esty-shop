require 'rails_helper'

RSpec.describe 'Bulk Discounts Index Page' do
  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }

  let!(:bulk_discount1) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount2) { create(:bulk_discount, merchant: merchant1) }
  let!(:bulk_discount3) { create(:bulk_discount, merchant: merchant2) }
  let!(:bulk_discount4) { create(:bulk_discount, merchant: merchant2) }

  before :each do
    visit merchant_discounts_path(merchant1)
  end

  describe 'When I visit the bulk discounts index page' do
    it 'displays all bulk discounts with their percentage discounts and quantity thresholds' do
      within '#current_discounts' do
        expect(page).to have_content("Percentage Discount - #{bulk_discount1.percentage_discount}")
        expect(page).to have_content("Quantity Threshold - #{bulk_discount1.quantity_threshold}")
        expect(page).to have_content("Percentage Discount - #{bulk_discount2.percentage_discount}")
        expect(page).to have_content("Quantity Threshold - #{bulk_discount2.quantity_threshold}")
        expect(page).not_to have_content("Percentage Discount - #{bulk_discount3.percentage_discount}")
        expect(page).not_to have_content("Quantity Threshold - #{bulk_discount3.quantity_threshold}")
        expect(page).not_to have_content("Percentage Discount - #{bulk_discount4.percentage_discount}")
        expect(page).not_to have_content("Quantity Threshold - #{bulk_discount4.quantity_threshold}")
      end
    end

    it 'has links to each bulk discount show page' do
      within '#current_discounts' do
        expect(page).to have_link("Discount #{bulk_discount1.id}")
        expect(page).to have_link("Discount #{bulk_discount2.id}")
        expect(page).not_to have_link("Discount #{bulk_discount3.id}")
        expect(page).not_to have_link("Discount #{bulk_discount4.id}")

        click_link("Discount #{bulk_discount1.id}")
      end

      expect(current_path).to eq(merchant_discount_path(merchant1, bulk_discount1))
    end

    it 'has a link to create a new discount' do
      within '#new_discount' do
        expect(page).to have_link('Create New Discount')
        click_link('Create New Discount')
      end

      expect(current_path).to eq(new_merchant_discount_path(merchant1))
    end

    it 'has a link to delete a discount' do
      within "#discount-#{bulk_discount1.id}" do
        expect(page).to have_link('Delete this discount')
      end
    end

    it 'deleting a discount returns to the index page with the discount no longer present' do
      within "#discount-#{bulk_discount1.id}" do
        click_link('Delete this discount')
      end

      within '#current_discounts' do
        expect(current_path).to eq(merchant_discounts_path(merchant1))
        expect(page).not_to have_content("Percentage Discount - #{bulk_discount1.percentage_discount}")
        expect(page).not_to have_content("Quantity Threshold - #{bulk_discount1.quantity_threshold}")
        expect(page).not_to have_link("Discount #{bulk_discount1.id}")
      end
    end

    it 'displays the next upcoming 3 US holidays' do
      holidays = HolidaySearch.new.upcoming_holidays
      expect(page).to have_content('Upcoming Holidays:')
      within '#upcoming_holidays' do
        expect(page).to have_content("#{holidays[0].name} Date: #{holidays[0].date}")
        expect(page).to have_content("#{holidays[1].name} Date: #{holidays[1].date}")
        expect(page).to have_content("#{holidays[2].name} Date: #{holidays[2].date}")
      end
    end
  end
end
