require 'rails_helper'

feature 'User creates answer', %q{
  As an authenticated user
  I want to be able to create answer for question
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:new_answer) { build(:answer) }

  scenario 'Authenticated user create answer.', js: true do
    sign_in user

    expect(page).to have_content 'Signed in successfully.'

    visit questions_path
    click_on question.title

    expect(current_path).to eq questions_path


    fill_in 'Your Answer', with: new_answer.body
    click_on 'Create answer'

    expect(current_path).to eq question_path(question)

    expect(page).to have_content new_answer.body
  end

  scenario 'Non authenticated user try to create answer',  js: true do
    visit questions_path
    click_on question.title

    expect(current_path).to eq question_path(question)

    expect(page).to_not have_content new_answer.body
    expect(page).to_not have_content 'Create answer'
    expect(page).to_not have_content 'Delete answer'
  end

end