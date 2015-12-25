require '/home/rubyman/Rails/qna/spec/acceptance/acceptance_helper'

feature 'User destroys his answer', %q{
  As a authenticated user
  I want to be able to delete only my answer
} do
  given(:other_user) {create(:user)}
  given!(:question) {create(:question)}
  given!(:answer) {create(:answer, question: question)}
    scenario 'Authenticated user deletes his answer' do
      sign_in answer.user
      visit question_path question

      click_on 'Delete answer'
      expect(page).to_not have_content answer.body
      expect(current_path).to eq question_path(question)
    end

    scenario 'Authenticated user deletes not his answer' do
     sign_in other_user
     visit question_path(question)

     expect(page).to_not have_link 'Delete answer'
    end

    scenario 'Guest deletes not his answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete answer'
  end
end

