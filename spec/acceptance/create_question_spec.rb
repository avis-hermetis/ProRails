require 'rails_helper'

feature 'User creates question', %q{
  In order to get the answer from the community
  As an authenticated user
  I want to be able to create question
} do
  given(:user) { create(:user) }
  scenario 'Authenticated user create question.' do
    visit new_user_session_path #используем DSL capybara(visit). Можно использовать хелперы, можно url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'testing title'
    fill_in 'Body', with: 'testing text'
    click_on 'Create'

    expect(page).to have_content ''
  end

  scenario 'Non authenticated user try to create question' do
    visit new_question_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end