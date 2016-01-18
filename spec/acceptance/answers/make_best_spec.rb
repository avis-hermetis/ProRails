require 'acceptance/acceptance_helper'

feature 'User selects answer as best answer', %q{
  As an author of the question
  In order distinguish answer that has helped me to solve the problem
  I want to be able to select teh best answer from the answers list
} do
  given!(:user) {create(:user)}
  given!(:other_user) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:other_user_question) {create(:question, user: other_user)}
  given!(:answer) {create(:answer, question: question)}


  scenario 'The author of the question select the best answer for his question' do
    sign_in user
    visit queston_path question
    expect(page).to have_content 'Choose as Best'

    click_on 'Choose as Best'
    expect(current_path).to eq question_path question
    expect(page).to have_content 'Best answer'

  end
  scenario 'Authenticated user tries to select the best answer for other user`s question`' do
    sign_in other
    visit queston_path question
    expect(page).to_not have_content 'Choose as Best'

  end
  scenario 'Not authenticated user tries to select  answer to be the best' do
    visit queston_path question
    expect(page).to_not have_content 'Choose as Best'

  end
end