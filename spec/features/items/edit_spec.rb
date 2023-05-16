require 'rails_helper'

RSpec.describe 'Merchant Items Edit Page', type: :feature do
  let!(:merchant1) { create(:merchant, name: 'Marvel') }
  let!(:merchant2) { create(:merchant, name: 'D.C.') }
  let!(:item1) { create(:item, name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant: merchant1) }
  let!(:item2) { create(:item, name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant: merchant2) }
  let!(:item3) { create(:item, name: 'Test', description: 'test', unit_price: 25, merchant: merchant1) }

  describe 'As a merchant' do
    describe 'When I visit the merchant show page of an item' do
      it 'displays a link to update the item information' do
        visit merchant_item_path(merchant1, item1)

        expect(page).to have_link('Edit Information')
      end
    end

    describe 'When I click the link' do
      it 'takes me to a page to edit the item' do
        visit merchant_item_path(merchant1, item1)

        click_link('Edit Information')

        expect(current_path).to eq(edit_merchant_item_path(merchant1, item1))
      end

      it 'displays a form filled in with the existing item attribute information' do
        visit edit_merchant_item_path(merchant1, item1)

        within('#edit_form') do
          expect(page).to have_content('Name:')
          expect(page).to have_field(:item_name)

          expect(page).to have_content('Description:')
          expect(page).to have_field(:item_description)

          expect(page).to have_content('Current selling price:')
          expect(page).to have_field(:item_unit_price)

          expect(page).to have_button('Update Information')
        end
      end

      describe 'When I update the information in the form and click submit' do
        it 'redirects me back to the item show page with the updated information and displays a success message' do
          visit edit_merchant_item_path(merchant1, item1)

          fill_in(:item_description, with: 'Stuffed animals that can be an investment')

          click_button('Update Information')

          expect(current_path).to eq(merchant_item_path(merchant1, item1))
          expect(page).to have_content('Information successfully updated')
        end
      end

      describe 'Sad path testing' do
        it 'returns an error if content is missing from the form and redirects back to the edit page' do
          visit edit_merchant_item_path(merchant1, item1)

          fill_in(:item_description, with: '')

          click_button('Update Information')

          expect(current_path).to eq(edit_merchant_item_path(merchant1, item1))
          expect(page).to have_content('Required content missing or unit price is invalid')
        end

        it 'returns an error if the unit price is not greater than zero' do
          visit edit_merchant_item_path(merchant1, item1)

          fill_in(:item_unit_price, with: -25)

          click_button('Update Information')

          expect(current_path).to eq(edit_merchant_item_path(merchant1, item1))
          expect(page).to have_content('Required content missing or unit price is invalid')
        end
      end
    end
  end
end
