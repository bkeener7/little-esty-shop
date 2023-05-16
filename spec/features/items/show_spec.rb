require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  let!(:merchant1) { create(:merchant, name: 'Marvel') }
  let!(:merchant2) { create(:merchant, name: 'D.C.') }

  let!(:item1) { create(:item, name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant: merchant1) }
  let!(:item2) { create(:item, name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant: merchant2) }
  let!(:item3) { create(:item, name: 'Test', description: 'test', unit_price: 25, merchant: merchant1) }

  describe 'As a merchant' do
    before do
      visit merchant_items_path(merchant1)
    end

    it "takes me to the item's show page when I click on its name" do
      within("#item-#{item1.id}") do
        click_link(item1.name)
      end

      expect(current_path).to eq(merchant_item_path(merchant1, item1))
    end

    it "displays all of the item's attributes on the show page" do
      visit merchant_item_path(merchant1, item1)

      expect(page).to have_content("Name: #{item1.name}")
      expect(page).to have_content("Description: #{item1.description}")
      expect(page).to have_content("Current Selling Price: $#{item1.unit_price}")
    end
  end
end
