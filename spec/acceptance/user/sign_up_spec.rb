require 'rails_helper'

feature 'Sign up', %q{
  In order to be able to ask question and creates answer
  As a guest
  I want to be able to sign up
} do

  given(:user) { build(:user) }
  given!(:registered_user) { create(:user) }

  scenario 'Guest tries to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'

    expect(current_path).to eq root_path
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario 'Already registered user tries to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: registered_user.email
    fill_in 'Password', with: registered_user.password
    fill_in 'Password confirmation', with: registered_user.password
    click_button 'Sign up'

    expect(current_path).to eq user_registration_path
    expect(page).to have_content "Email has already been taken"
  end
end