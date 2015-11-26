require 'rails_helper'

feature 'User sign out', %q{
  In order to quit
  As an user
  I want to be able to log out
} do
  given(:user) { create(:user) }
    scenario 'Authenticated user logs out.' do
      visit new_user_session_path #используем DSL capybara(visit). Можно использовать хелперы, можно url
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'

      expect(page).to have_content 'Signed in successfully.'
      click_on 'Log out'


      expect(page).to have_content 'Loged out successfully.' #Используются сообщения, которые будут в девайсе.
      expect(page).to_not have_link 'Log out'
      expect(current_path).to eq root_path
    end

    scenario 'Non_authenticated user logs out' do
      expect(page).to_not have_link 'Log out'
      expect(page).to have_link 'Log in'
    end
end