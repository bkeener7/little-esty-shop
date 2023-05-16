require 'rails_helper'

RSpec.describe 'Merchant Items Index Page', type: :feature do
  let!(:merchant1) { create(:merchant, name: 'Marvel') }
  let!(:merchant2) { create(:merchant, name: 'D.C.') }
  let!(:customer1) { create(:customer, first_name: 'Peter', last_name: 'Parker') }
  let!(:customer2) { create(:customer, first_name: 'Clark', last_name: 'Kent') }
  let!(:customer3) { create(:customer, first_name: 'Louis', last_name: 'Lane') }
  let!(:customer4) { create(:customer, first_name: 'Lex', last_name: 'Luther') }
  let!(:customer5) { create(:customer, first_name: 'Frank', last_name: 'Castle') }
  let!(:customer6) { create(:customer, first_name: 'Matt', last_name: 'Murdock') }
  let!(:customer7) { create(:customer, first_name: 'Bruce', last_name: 'Wayne') }
  let!(:invoice1) { create(:invoice, status: 'completed', customer: customer1, created_at: '2009-05-01 01:31:45') }
  let!(:invoice2) { create(:invoice, status: 'completed', customer: customer2, created_at: '2009-06-02 01:35:45') }
  let!(:invoice3) { create(:invoice, status: 'completed', customer: customer3, created_at: '2009-07-03 01:22:45') }
  let!(:invoice4) { create(:invoice, status: 'cancelled', customer: customer4, created_at: '2009-08-04 01:09:45') }
  let!(:invoice5) { create(:invoice, status: 'completed', customer: customer5, created_at: '2009-09-05 01:08:45') }
  let!(:invoice6) { create(:invoice, status: 'completed', customer: customer6, created_at: '2009-10-06 01:59:45') }
  let!(:invoice7) { create(:invoice, status: 'completed', customer: customer7, created_at: '2009-11-07 01:00:45') }
  let!(:invoice8) { create(:invoice, status: 'completed', customer: customer1, created_at: '2009-12-08 01:12:45') }
  let!(:invoice9) { create(:invoice, status: 'completed', customer: customer2, created_at: '2010-01-09 01:16:45') }
  let!(:invoice10) { create(:invoice, status: 'completed', customer: customer2, created_at: '2010-02-10 01:54:45') }
  let!(:invoice11) { create(:invoice, status: 'completed', customer: customer3, created_at: '2010-03-11 01:48:45') }
  let!(:invoice12) { create(:invoice, status: 'completed', customer: customer7, created_at: '2010-03-11 01:51:45') }
  let!(:invoice13) { create(:invoice, status: 'completed', customer: customer7, created_at: '2010-04-12 01:39:45') }
  let!(:invoice14) { create(:invoice, status: 'completed', customer: customer2, created_at: '2010-05-13 01:38:45') }
  let!(:invoice15) { create(:invoice, status: 'completed', customer: customer7, created_at: '2010-06-14 01:24:45') }
  let!(:invoice16) { create(:invoice, status: 'completed', customer: customer7, created_at: '2010-07-15 01:28:45') }
  let!(:invoice17) { create(:invoice, status: 'completed', customer: customer7, created_at: '2010-08-16 01:31:45') }
  let!(:invoice18) { create(:invoice, status: 'completed', customer: customer7, created_at: '2010-09-17 01:42:45') }
  let!(:item1) { create(:item, name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant: merchant1) }
  let!(:item2) { create(:item, name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant: merchant2) }
  let!(:item3) { create(:item, name: 'Bat Mask', description: 'Identity Protection', unit_price: 800, merchant: merchant1) }
  let!(:item4) { create(:item, name: 'Leotard', description: 'Costume', unit_price: 1850, merchant: merchant1) }
  let!(:item5) { create(:item, name: 'Cape', description: 'Fully Functional', unit_price: 900, merchant: merchant1) }
  let!(:item6) { create(:item, name: 'Black Makeup', description: 'Gallon Sized', unit_price: 50, merchant: merchant1) }
  let!(:item7) { create(:item, name: 'Batmobile', description: 'Only one left in stock', unit_price: 1000000, merchant: merchant1) }
  let!(:item8) { create(:item, name: 'Night-Vision Goggles', description: 'Required for night activities', unit_price: 15000, merchant: merchant1) }
  let!(:item9) { create(:item, name: 'Bat-Cave', description: 'Bats not included', unit_price: 10000000, merchant: merchant2) }
  let!(:invoice_item1) { create(:invoice_item, quantity: 5, unit_price: 100, status: 'packaged', item: item1, invoice: invoice1) }
  let!(:invoice_item2) { create(:invoice_item, quantity: 1, unit_price: 100, status: 'shipped', item: item1, invoice: invoice2) }
  let!(:invoice_item3) { create(:invoice_item, quantity: 6, unit_price: 100, status: 'pending', item: item1, invoice: invoice3) }
  let!(:invoice_item4) { create(:invoice_item, quantity: 12, unit_price: 100, status: 'packaged', item: item1, invoice: invoice4) }
  let!(:invoice_item5) { create(:invoice_item, quantity: 8, unit_price: 100, status: 'packaged', item: item1, invoice: invoice5) }
  let!(:invoice_item6) { create(:invoice_item, quantity: 20, unit_price: 100, status: 'packaged', item: item1, invoice: invoice6) }
  let!(:invoice_item7) { create(:invoice_item, quantity: 50, unit_price: 500, status: 'shipped', item: item2, invoice: invoice7) }
  let!(:invoice_item8) { create(:invoice_item, quantity: 15, unit_price: 500, status: 'shipped', item: item2, invoice: invoice8) }
  let!(:invoice_item9) { create(:invoice_item, quantity: 15, unit_price: 100, status: 'shipped', item: item1, invoice: invoice9) }
  let!(:invoice_item10) { create(:invoice_item, quantity: 15, unit_price: 100, status: 'shipped', item: item1, invoice: invoice10) }
  let!(:invoice_item11) { create(:invoice_item, quantity: 15, unit_price: 100, status: 'shipped', item: item1, invoice: invoice11) }
  let!(:invoice_item12) { create(:invoice_item, quantity: 50, unit_price: 800, status: 'shipped', item: item3, invoice: invoice12) }
  let!(:invoice_item13) { create(:invoice_item, quantity: 100, unit_price: 1850, status: 'shipped', item: item4, invoice: invoice13) }
  let!(:invoice_item14) { create(:invoice_item, quantity: 20, unit_price: 900, status: 'shipped', item: item5, invoice: invoice14) }
  let!(:invoice_item15) { create(:invoice_item, quantity: 100, unit_price: 50, status: 'shipped', item: item6, invoice: invoice15) }
  let!(:invoice_item16) { create(:invoice_item, quantity: 1, unit_price: 1000000, status: 'shipped', item: item7, invoice: invoice16) }
  let!(:invoice_item17) { create(:invoice_item, quantity: 5, unit_price: 15000, status: 'shipped', item: item8, invoice: invoice17) }
  let!(:invoice_item18) { create(:invoice_item, quantity: 1, unit_price: 10000000, status: 'shipped', item: item9, invoice: invoice18) }
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
  let!(:transaction15) { create(:transaction, credit_card_number: '4801647818676137', result: 'success', invoice: invoice12) }
  let!(:transaction16) { create(:transaction, credit_card_number: '4801647818676138', result: 'success', invoice: invoice13) }
  let!(:transaction17) { create(:transaction, credit_card_number: '4801647818676139', result: 'success', invoice: invoice14) }
  let!(:transaction18) { create(:transaction, credit_card_number: '4801647818676146', result: 'success', invoice: invoice15) }
  let!(:transaction19) { create(:transaction, credit_card_number: '4801647818676147', result: 'success', invoice: invoice16) }
  let!(:transaction20) { create(:transaction, credit_card_number: '4801647818676148', result: 'success', invoice: invoice17) }
  let!(:transaction21) { create(:transaction, credit_card_number: '4801647818676149', result: 'success', invoice: invoice18) }

  describe 'As a merchant' do
    before do
      visit merchant_items_path(merchant1)
    end

    it 'displays the merchant inventory' do
      expect(page).to have_content("#{merchant1.name} Inventory")
      expect(page).to have_content('Items:')
      expect(page).to_not have_content('Bat-A-Rangs')
    end

    it 'displays the list of item names and buttons to enable or disable each item' do
      within("#item-#{item1.id}") do
        expect(page).to have_content(item1.name)
        expect(page).to have_button('Enable')
      end

      within("#item-#{item3.id}") do
        expect(page).to have_content(item3.name)
        expect(page).to have_button('Enable')
      end
    end

    it 'updates the item status when the enable/disable button is clicked' do
      within("#item-#{item1.id}") do
        expect(page).to have_content('Status: disabled')
      end

      within("#item-#{item3.id}") do
        expect(page).to have_content('Status: disabled')
        click_button('Enable')
      end

      within("#item-#{item3.id}") do
        expect(page).to have_content('Status: enabled')
        expect(page).to have_button('Disable')
        expect(page).to_not have_content('Status: disabled')
        click_button('Disable')
        expect(page).to have_content('Status: disabled')
      end

      within("#item-#{item1.id}") do
        expect(page).to_not have_content('Status: enabled')
      end
    end

    it 'displays enabled and disabled items in separate sections' do
      item4 = create(:item, name: 'Test2', description: 'test', unit_price: 25, status: 1, merchant: merchant1)
      visit merchant_items_path(merchant1)

      within('#enabled') do
        expect(page).to have_content('Enabled Items')
        expect(page).to have_link(item4.name)
        expect(page).to_not have_link(item1.name)
      end

      within('#disabled') do
        expect(page).to have_content('Disabled Items')
        expect(page).to have_link(item1.name)
        expect(page).to have_link(item3.name)
        expect(page).to_not have_link(item4.name)
      end
    end

    it 'displays the top 5 items by total revenue' do
      within('#top_by_revenue') do
        expect(page).to have_content(item7.name)
        expect(page).to have_content(item4.name)
        expect(page).to have_content(item8.name)
        expect(page).to have_content(item3.name)
        expect(page).to have_content(item5.name)

        expect("#{item7.name}").to appear_before("#{item4.name}")
        expect("#{item4.name}").to appear_before("#{item8.name}")
        expect("#{item8.name}").to appear_before("#{item3.name}")
        expect("#{item3.name}").to appear_before("#{item5.name}")
      end
    end

    it 'displays links to each item show page and the total revenue generated for each item' do
      within('#top_by_revenue') do
        expect(page).to have_link(item7.name)
        expect(page).to have_link(item4.name)
        expect(page).to have_link(item8.name)
        expect(page).to have_link(item3.name)
        expect(page).to have_link(item5.name)

        expect(page).to have_content(merchant1.top_items_by_revenue[0].item_revenue)
        expect(page).to have_content(merchant1.top_items_by_revenue[1].item_revenue)
        expect(page).to have_content(merchant1.top_items_by_revenue[2].item_revenue)
        expect(page).to have_content(merchant1.top_items_by_revenue[3].item_revenue)
        expect(page).to have_content(merchant1.top_items_by_revenue[4].item_revenue)
      end
    end

    it 'displays the 5 most popular items with the date of the most sales for each item' do
      within('#top_by_revenue') do
        expect(page).to have_content("Top selling date was: #{item7.top_item_selling_date}")
        expect(page).to have_content("Top selling date was: #{item4.top_item_selling_date}")
        expect(page).to have_content("Top selling date was: #{item8.top_item_selling_date}")
        expect(page).to have_content("Top selling date was: #{item3.top_item_selling_date}")
        expect(page).to have_content("Top selling date was: #{item5.top_item_selling_date}")

        expect('Batmobile').to appear_before('Leotard')
        expect('Leotard').to appear_before('Night-Vision Goggles')
        expect('Night-Vision Goggles').to appear_before('Bat Mask')
        expect('Bat Mask').to appear_before('Cape')
      end
    end
  end
end
