require 'rails_helper'

RSpec.describe 'Merchant Item New Page' do
  let!(:merchant1) { create(:merchant, name: 'Marvel') }
  let!(:merchant2) { create(:merchant, name: 'D.C.') }

  describe 'As a merchant' do
    before do
      visit merchant_items_path(merchant1)
    end

    it 'displays a link to create a new item' do
      within('#new_item') do
        expect(page).to have_link('Create a New Item')
      end
    end

    describe 'When I click the link' do
      before do
        click_link('Create a New Item')
      end

      it 'takes me to a form to add item information' do
        expect(current_path).to eq(new_merchant_item_path(merchant1))

        within('#create_item') do
          expect(page).to have_content('Name:')
          expect(page).to have_field(:name)
          expect(page).to have_content('Description:')
          expect(page).to have_field(:description)
          expect(page).to have_content('Current selling price:')
          expect(page).to have_field(:unit_price)
          expect(page).to have_button('Create Item')
        end
      end

      describe 'When I fill out the form and click Submit' do
        before do
          fill_in(:name, with: 'Boots')
          fill_in(:description, with: 'Made for walking')
          fill_in(:unit_price, with: 150)
          click_button('Create Item')
        end

        it 'takes me back to the items index page and displays the created item' do
          expect(current_path).to eq(merchant_items_path(merchant1))

          within("#item-#{merchant1.items.last.id}") do
            expect(page).to have_link('Boots')
            expect(page).to have_content('Status: disabled')
          end
        end
      end

      describe 'Sad path testing :(' do
        before do
          click_button('Create Item')
        end

        it 'returns an error if content is missing from the form and redirects back to the new page' do
          expect(current_path).to eq(new_merchant_item_path(merchant1))
          expect(page).to have_content('Required content missing or unit price is invalid')
        end
      end
    end
  end
end
