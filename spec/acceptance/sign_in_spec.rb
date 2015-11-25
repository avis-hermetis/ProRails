require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask questions
  As an user
  I want to be able to sign_in
} do
  given(:user) { create(:user) }

    scenario 'Registered user try to sign in' do
      visit new_user_session_path #используем DSL capybara(visit). Можно использовать хелперы, можно url
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'

      expect(page).to have_content 'Signed in successfully.' #Используются сообщения, которые будут в девайсе.
      expect(current_path).to eq root_path
    end

    scenario 'Unregistered user try to sign in' do

      visit new_user_session_path #используем DSL capybara(visit). Можно использовать хелперы, можно url
      fill_in 'Email', with: 'wrong@test.com' #incorrect email
      fill_in 'Password', with: '12345678'
      click_on 'Log in'

      expect(page).to have_content 'Invalid email or password.' #Используются сообщения, которые будут в девайсе.
      expect(current_path).to eq new_user_session_path #остались на той же странице
      end
  end