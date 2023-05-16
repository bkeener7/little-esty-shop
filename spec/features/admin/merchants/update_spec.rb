require 'rails_helper'

RSpec.describe 'admin/merchants-show page' do
  let!(:merchant_1) { Merchant.create!(name: 'Marvel') }
  let!(:merchant_2) { Merchant.create!(name: 'D.C.') }
  let!(:merchant_3) { Merchant.create!(name: 'Darkhorse') }
  let!(:merchant_4) { Merchant.create!(name: 'Image') }

  it 'updates merchant information when the user submits the form' do
    visit admin_merchant_path(merchant_1)

    expect(page).to have_link('Update Merchant')
    click_link 'Update Merchant'

    expect(current_path).to eq(edit_admin_merchant_path(merchant_1))

    fill_in 'Name', with: 'Ms. Marvel'
    click_button 'Submit'

    expect(current_path).to eq(admin_merchant_path(merchant_1))
    expect(page).to have_content('Successfully Updated: Ms. Marvel')
    expect(page).to have_content('Ms. Marvel')
  end

  it 'returns an error message when the name field is empty' do
    visit admin_merchant_path(merchant_1)

    expect(page).to have_link('Update Merchant')
    click_link 'Update Merchant'

    expect(current_path).to eq(edit_admin_merchant_path(merchant_1))

    fill_in 'Name', with: ''
    click_button 'Submit'

    expect(current_path).to eq(edit_admin_merchant_path(merchant_1))
    expect(page).to have_content('Empty name not permitted. Please input valid name')
  end
end
