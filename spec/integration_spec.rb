require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the app', :type => :feature) do
  describe('The add train path') do
    it('adds a train to the system') do
      visit('/system_operator')
      click_link('Add Train')
      fill_in('train_name', :with => 'Frank the Tank')
      click_button('Add')
      expect(page).to have_content('Frank')
    end
  end

  describe('the add city path') do
    it('adds a city to the system') do
      visit('/system_operator/add_city')
      fill_in('city_name', :with => 'Boston')
      click_button('Add')
      expect(page).to have_content('Boston')
    end
  end

end
