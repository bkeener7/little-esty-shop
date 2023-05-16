require 'rails_helper'

RSpec.describe 'admin/merchants-show page' do
  let!(:merchant_1) { create(:merchant, name: 'Marvel') }
  let!(:merchant_2) { create(:merchant, name: 'D.C.') }
  let!(:merchant_3) { create(:merchant, name: 'Darkhorse') }
  let!(:merchant_4) { create(:merchant, name: 'Image') }

  describe 'when I click on the name of the merchant I am taken to the merchant show page' do
    before { visit admin_merchants_path }

    it "each name links to a merchant's show page" do
      expect(page).to have_link(merchant_1.name, href: admin_merchant_path(merchant_1))
      expect(page).to have_link(merchant_2.name, href: admin_merchant_path(merchant_2))
      expect(page).to have_link(merchant_3.name, href: admin_merchant_path(merchant_3))
      expect(page).to have_link(merchant_4.name, href: admin_merchant_path(merchant_4))

      click_link merchant_1.name

      expect(current_path).to eq(admin_merchant_path(merchant_1))

      expect(page).to have_content(merchant_1.name)
      expect(page).not_to have_content(merchant_2.name)
    end
  end
end
