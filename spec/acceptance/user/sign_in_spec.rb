require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask questions
  As an user
  I want to be able to sign_in
} do
  given(:user) { create(:user) }
  given(:not_registered_user) { build(:user) }

    scenario 'Registered user try to sign in' do
      sign_in user

      expect(page).to have_content 'Signed in successfully.' #Используются сообщения, которые будут в девайсе.
      expect(current_path).to eq root_path
    end

    scenario 'Unregistered user try to sign in' do
      sign_in not_registered_user

      expect(page).to have_content 'Invalid email or password.' #Используются сообщения, которые будут в девайсе.
      expect(current_path).to eq new_user_session_path #остались на той же странице
      end
  end