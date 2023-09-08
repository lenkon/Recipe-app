require 'rails_helper'

RSpec.describe 'Index page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Emmanuel', username: DateTime.now.to_s, email: "#{DateTime.now}@gmail.com",
                        password: 'x',
                        password_confirmation: 'x')
  end

  describe 'index page' do
    it 'shows the right content' do
      visit root_path
      expect(page).to have_content('Sign In')
    end

    it 'should have the right content' do
      visit root_path
      expect(page).to have_content("Don't have an account yet?")
    end
  end
end
