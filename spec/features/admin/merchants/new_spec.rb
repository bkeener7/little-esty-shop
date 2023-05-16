require 'rails_helper'

RSpec.describe 'Create new merchant' do
  it 'has a link on the admin dashboard form to create a new merchant and the status is set to disabled by default' do
    visit admin_merchants_path

    within('#admin_dashboard') do
      expect(page).to have_link('New Merchant')
      click_link 'New Merchant'
    end

    expect(current_path).to eq(new_admin_merchant_path)

    fill_in 'Name', with: 'Banana Fran'
    click_button 'Create Merchant'
    expect(current_path).to eq(admin_merchants_path)

    within('#disabled_merchants') do
      expect(page).to have_content('Banana Fran')
    end
  end

  it 'returns an error message if the name is not inputted' do
    visit admin_merchants_path

    expect(page).to have_link('New Merchant')
    click_link 'New Merchant'

    expect(current_path).to eq(new_admin_merchant_path)

    fill_in 'Name', with: nil
    click_button 'Create Merchant'
    expect(current_path).to eq(new_admin_merchant_path)
    expect(page).to have_content('ERROR: Please enter a valid name.')
  end
end
