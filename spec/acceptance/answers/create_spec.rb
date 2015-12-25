require '/home/rubyman/Rails/qna/spec/acceptance/acceptance_helper'

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
    expect(page).to have_content question.title
    click_on question.title

    expect(current_path).to eq question_path(question)


    fill_in 'Your Answer', with: new_answer.body
    click_on 'Create answer'

    expect(current_path).to eq question_path(question)

    expect(page).to have_content new_answer.body
  end

  scenario 'Non authenticated user try to create answer',  js: true do
    visit questions_path

    expect(page).to have_content question.title
    click_on question.title

    expect(current_path).to eq question_path(question)

    expect(page).to_not have_content new_answer.body
    expect(page).to_not have_content 'Create answer'
    expect(page).to_not have_content 'Delete answer'
  end

  scenario 'User tries to create invalid answer', js: true do
    sign_in user
    visit question_path question

    click_on 'Create answer'

    expect(page).to have_content "Body can't be blank"

  end

end