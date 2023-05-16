require 'rails_helper'

RSpec.describe 'admin/merchants index page' do
  let!(:merchant_1) { create(:merchant, name: 'Marvel', status: 'enabled') }
  let!(:merchant_2) { create(:merchant, name: 'D.C.', status: 'disabled') }
  let!(:merchant_3) { create(:merchant, name: 'Darkhorse', status: 'enabled') }
  let!(:merchant_4) { create(:merchant, name: 'Image', status: 'disabled') }
  let!(:merchant_5) { create(:merchant, name: 'Wonders', status: 'enabled') }
  let!(:merchant_6) { create(:merchant, name: 'Disney', status: 'enabled') }

  let!(:customer1) { create(:customer, first_name: 'Peter', last_name: 'Parker') }
  let!(:customer2) { create(:customer, first_name: 'Clark', last_name: 'Kent') }
  let!(:customer3) { create(:customer, first_name: 'Louis', last_name: 'Lane') }
  let!(:customer4) { create(:customer, first_name: 'Lex', last_name: 'Luther') }
  let!(:customer5) { create(:customer, first_name: 'Frank', last_name: 'Castle') }
  let!(:customer6) { create(:customer, first_name: 'Matt', last_name: 'Murdock') }
  let!(:customer7) { create(:customer, first_name: 'Bruce', last_name: 'Wayne') }

  let!(:invoice1) { create(:invoice, status: 'completed', customer: customer1, created_at: Time.parse('21.01.28')) }
  let!(:invoice2) { create(:invoice, status: 'completed', customer: customer2, created_at: Time.parse('22.08.22')) }
  let!(:invoice3) { create(:invoice, status: 'completed', customer: customer3, created_at: Time.parse('22.07.04')) }
  let!(:invoice4) { create(:invoice, status: 'cancelled', customer: customer4, created_at: Time.parse('21.09.14')) }
  let!(:invoice5) { create(:invoice, status: 'completed', customer: customer5, created_at: Time.parse('22.10.10')) }
  let!(:invoice6) { create(:invoice, status: 'completed', customer: customer6, created_at: Time.parse('22.10.15')) }
  let!(:invoice7) { create(:invoice, status: 'completed', customer: customer7, created_at: Time.parse('21.12.25')) }
  let!(:invoice8) { create(:invoice, status: 'completed', customer: customer1, created_at: Time.parse('20.02.22')) }
  let!(:invoice9) { create(:invoice, status: 'completed', customer: customer2, created_at: Time.parse('22.06.12')) }
  let!(:invoice10) { create(:invoice, status: 'completed', customer: customer2, created_at: Time.parse('22.03.14')) }
  let!(:invoice11) { create(:invoice, status: 'completed', customer: customer3, created_at: Time.parse('22.03.17')) }

  let!(:item1) { create(:item, name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant: merchant_1) }
  let!(:item2) { create(:item, name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant: merchant_2) }
  let!(:item3) { create(:item, name: 'Bat Mask', description: 'Identity Protection', unit_price: 800, merchant: merchant_2) }
  let!(:item4) { create(:item, name: 'Leotard', description: 'Costume', unit_price: 1850, merchant: merchant_3) }
  let!(:item5) { create(:item, name: 'Cape', description: 'Fully Functional', unit_price: 900, merchant: merchant_4) }
  let!(:item6) { create(:item, name: 'Black Makeup', description: 'Gallon Sized', unit_price: 50, merchant: merchant_5) }
  let!(:item7) { create(:item, name: 'Batmobile', description: 'Only one left in stock', unit_price: 1000000, merchant: merchant_5) }
  let!(:item8) { create(:item, name: 'Night-Vision Goggles', description: 'Required for night activities', unit_price: 15000, merchant: merchant_6) }
  let!(:item9) { create(:item, name: 'Bat-Cave', description: 'Bats not included', unit_price: 10000000, merchant: merchant_6) }

  let!(:invoice_item1) { create(:invoice_item, quantity: 5, unit_price: 500, status: 'packaged', item: item1, invoice: invoice1) }
  let!(:invoice_item2) { create(:invoice_item, quantity: 1, unit_price: 100, status: 'shipped', item: item1, invoice: invoice2) }
  let!(:invoice_item3) { create(:invoice_item, quantity: 6, unit_price: 600, status: 'pending', item: item1, invoice: invoice3) }
  let!(:invoice_item4) { create(:invoice_item, quantity: 12, unit_price: 1200, status: 'packaged', item: item1, invoice: invoice4) }
  let!(:invoice_item5) { create(:invoice_item, quantity: 8, unit_price: 800, status: 'packaged', item: item1, invoice: invoice5) }
  let!(:invoice_item6) { create(:invoice_item, quantity: 20, unit_price: 2000, status: 'packaged', item: item1, invoice: invoice6) }
  let!(:invoice_item7) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item1, invoice: invoice9) }
  let!(:invoice_item8) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item1, invoice: invoice10) }
  let!(:invoice_item9) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item1, invoice: invoice11) }
  let!(:invoice_item10) { create(:invoice_item, quantity: 50, unit_price: 5000, status: 'shipped', item: item2, invoice: invoice7) }
  let!(:invoice_item11) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item2, invoice: invoice8) }
  let!(:invoice_item12) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item3, invoice: invoice7) }
  let!(:invoice_item13) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item3, invoice: invoice11) }
  let!(:invoice_item14) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item3, invoice: invoice11) }
  let!(:invoice_item15) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item4, invoice: invoice11) }
  let!(:invoice_item16) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item4, invoice: invoice6) }
  let!(:invoice_item17) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item4, invoice: invoice6) }
  let!(:invoice_item18) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item5, invoice: invoice11) }
  let!(:invoice_item19) { create(:invoice_item, quantity: 30, unit_price: 1500, status: 'shipped', item: item6, invoice: invoice8) }
  let!(:invoice_item20) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item6, invoice: invoice8) }
  let!(:invoice_item21) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item6, invoice: invoice8) }
  let!(:invoice_item22) { create(:invoice_item, quantity: 15, unit_price: 1500, status: 'shipped', item: item7, invoice: invoice11) }
  let!(:invoice_item23) { create(:invoice_item, quantity: 5, unit_price: 1500, status: 'shipped', item: item7, invoice: invoice11) }
  let!(:invoice_item24) { create(:invoice_item, quantity: 10, unit_price: 100, status: 'shipped', item: item8, invoice: invoice11) }
  let!(:invoice_item25) { create(:invoice_item, quantity: 15, unit_price: 100, status: 'shipped', item: item8, invoice: invoice11) }
  let!(:invoice_item26) { create(:invoice_item, quantity: 11, unit_price: 1350, status: 'shipped', item: item9, invoice: invoice11) }
  let!(:invoice_item27) { create(:invoice_item, quantity: 4, unit_price: 1350, status: 'shipped', item: item9, invoice: invoice11) }

  let!(:transaction1) { create(:transaction, credit_card_number: '4801647818676136', result: 'failed', invoice: invoice1) }
  let!(:transaction2) { create(:transaction, credit_card_number: '4654405418249632', result: 'success', invoice: invoice1) }
  let!(:transaction3) { create(:transaction, credit_card_number: '4800749911485986', result: 'success', invoice: invoice2) }
  let!(:transaction4) { create(:transaction, credit_card_number: '4923661117104166', result: 'success', invoice: invoice3) }
  let!(:transaction5) { create(:transaction, credit_card_number: '4536896899874279', result: 'failed', invoice: invoice4) }
  let!(:transaction6) { create(:transaction, credit_card_number: '4536896899874280', result: 'failed', invoice: invoice4) }
  let!(:transaction7) { create(:transaction, credit_card_number: '4536896899874281', result: 'success', invoice: invoice5) }
  let!(:transaction8) { create(:transaction, credit_card_number: '4536896899874286', result: 'failed', invoice: invoice6) }
  let!(:transaction9) { create(:transaction, credit_card_number: '4636896899874290', result: 'success', invoice: invoice6) }
  let!(:transaction10) { create(:transaction, credit_card_number: '4636896899874291', result: 'success', invoice: invoice7) }
  let!(:transaction11) { create(:transaction, credit_card_number: '4636896899874298', result: 'success', invoice: invoice8) }
  let!(:transaction12) { create(:transaction, credit_card_number: '4636896899878732', result: 'success', invoice: invoice9) }
  let!(:transaction13) { create(:transaction, credit_card_number: '4636896899878732', result: 'success', invoice: invoice10) }
  let!(:transaction14) { create(:transaction, credit_card_number: '4636896899845752', result: 'success', invoice: invoice11) }

  describe 'when I visit the merchant index I see a name for each merchant' do
    it 'shows the name of each merchant' do
      visit admin_merchants_path
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content(merchant_2.name)
      expect(page).to have_content(merchant_3.name)
      expect(page).to have_content(merchant_4.name)
    end

    it "each name links to a merchant's show page" do
      visit admin_merchants_path

      within('#disabled_merchants') do
        expect(page).to have_link(merchant_2.name, href: admin_merchant_path(merchant_2))
        expect(page).to have_link(merchant_4.name, href: admin_merchant_path(merchant_4))
      end

      within('#enabled_merchants') do
        expect(page).to have_link(merchant_1.name, href: admin_merchant_path(merchant_1))
        expect(page).to have_link(merchant_3.name, href: admin_merchant_path(merchant_3))
        expect(page).to have_link(merchant_5.name, href: admin_merchant_path(merchant_5))
        expect(page).to have_link(merchant_6.name, href: admin_merchant_path(merchant_6))
        click_on merchant_1.name
      end

      expect(current_path).to eq(admin_merchant_path(merchant_1))
    end
  end

  describe 'as an admin, I see a button to update a merchants status' do
    it 'has buttons next to each merchant to enable or disable' do
      visit admin_merchants_path
      within("#merchant-#{merchant_1.id}") do
        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end
      within("#merchant-#{merchant_2.id}") do
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end

      within("#merchant-#{merchant_3.id}") do
        expect(page).to have_content(merchant_3.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{merchant_4.id}") do
        expect(page).to have_content(merchant_4.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end
    end

    it 'can disable a merchant by clicking the disable button' do
      visit admin_merchants_path

      within("#merchant-#{merchant_1.id}") do
        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')

        click_button 'Disable'
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end

      within("#merchant-#{merchant_2.id}") do
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end

      within("#merchant-#{merchant_3.id}") do
        expect(page).to have_content(merchant_3.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{merchant_4.id}") do
        expect(page).to have_content(merchant_4.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end
    end

    it 'can enable a merchant by clicking the enable button' do
      visit admin_merchants_path

      within("#merchant-#{merchant_1.id}") do
        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{merchant_2.id}") do
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')

        click_button 'Enable'
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{merchant_3.id}") do
        expect(page).to have_content(merchant_3.name)
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end

      within("#merchant-#{merchant_4.id}") do
        expect(page).to have_content(merchant_4.name)
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end
    end
  end

  describe 'top 5 merchants displayed on admin merchants index' do
    it 'displays the top 5 merchants with the highest total revenue based on unit_price * quantity' do
      visit admin_merchants_path
      within('#top_merchants') do
        expect("#{merchant_2.name}").to appear_before("#{merchant_1.name}")
        expect("#{merchant_1.name}").to appear_before("#{merchant_5.name}")
        expect("#{merchant_5.name}").to appear_before("#{merchant_3.name}")
        expect("#{merchant_3.name}").to appear_before("#{merchant_6.name}")
        expect(page).to_not have_content(merchant_4)
      end
    end

    it 'has links to the show page of each top merchant' do
      visit admin_merchants_path

      within('#top_merchants') do
        expect(page).to have_link(merchant_1.name)
        expect(page).to have_link(merchant_2.name)
        expect(page).to have_link(merchant_3.name)
        expect(page).to have_link(merchant_5.name)
        expect(page).to have_link(merchant_6.name)
        expect(page).not_to have_link(merchant_4.name)
      end
    end

    it 'displays the top selling date for each of the top 5 merchants' do
      visit admin_merchants_path

      within('#top_merchants') do
        expect(page).to have_content('Top selling date was 12/25/2021')
        expect(page).to have_content('Top selling date was 10/15/2022')
        expect(page).to have_content('Top selling date was 12/25/2021')
        expect(page).to have_content('Top selling date was 10/15/2022')
        expect(page).to have_content('Top selling date was 03/17/2022')
      end
    end
  end
end
