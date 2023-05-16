require 'rails_helper'

RSpec.describe 'Welcome Page', type: :feature do
  before :each do
    visit root_path
  end

  describe 'links' do
    it 'has a link to the Admin page' do
      expect(page).to have_link('Admin')
    end

    it 'has a link to the Admin Merchants page' do
      expect(page).to have_link('Admin Merchants')
    end

    it 'has a link to the Admin Invoices page' do
      expect(page).to have_link('Admin Invoices')
    end
  end
end
