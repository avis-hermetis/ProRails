require '/home/rubyman/Rails/qna/spec/acceptance/acceptance_helper'

feature 'User creates question', %q{
  In order to get the answer from the community
  As an authenticated user
  I want to be able to create question
} do
  given(:user) { create(:user) }
  given(:new_question) { build(:question) }

  scenario 'Authenticated user create question.' do
    sign_in user

    expect(page).to have_content 'Signed in successfully.'

    visit questions_path

    click_on 'Ask question'
    fill_in 'Title', with: new_question.title
    fill_in 'Body', with: new_question.body
    click_on 'Create'

    expect(page).to have_content new_question.title
    expect(page).to have_content new_question.body
  end

  scenario 'Non authenticated user try to create question' do
    visit root_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end

end