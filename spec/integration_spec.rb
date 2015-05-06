require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the app', :type => :feature) do
  describe('/system_operator') do
    it('Visits system operator page') do
      visit('/system_operator')
      expect(page).to(have_content('Operate the system!'))
    end
  end

  describe('The system operator path') do
    it('adds a train to the system') do
      visit('/system_operator')
      click_link('Add Train')
      fill_in('train_name', :with => 'Frank the Tank')
      click_button('Add Train')
      expect(page).to have_content('Train Added')
    end
  end

end
