require 'acceptance/acceptance_helper'

feature 'User edits answer', %q{
  In order to fix mistake
  As an authenticated user
  I want to be able to edit answer for question
} do
  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:other_user_answer) { create(:answer, question: question, user: other_user) }

  context 'Authenticated user' do
    before do
      sign_in user
      visit question_path question
    end

    scenario 'tries to edit other user`s` answer.', js: true do
      within "#answer_#{other_user_answer.id}" do
        expect(page).to_not have_link 'Edit'
      end
    end


    scenario 'tries to edit his answer.', js: true do
      click_link 'Edit'
      within "#answer_#{answer.id}" do
        fill_in 'Answer', with: 'edited answer'
        click_on 'Save' 
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end


  end

  context 'Not authenticated user' do
     scenario 'do not see the Edit link', js: true do
      visit question_path question

      expect(page).to_not have_link 'Edit'
     end
  end
end
