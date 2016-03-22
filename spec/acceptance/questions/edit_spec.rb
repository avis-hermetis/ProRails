require 'acceptance/acceptance_helper'

feature 'User edits question', %q{
  In order to fix mistake
  As an authenticated user
  I want to be able to edit my answer
} do
  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:other_user_question) { create(:question, user: other_user) }

  context 'Authenticated user' do
    before do
      sign_in user
    end

    scenario 'tries to edit other user`s question.', js: true do
      visit question_path other_user_question

      within "#question_#{other_user_question.id}" do
        expect(page).to_not have_link 'Edit'
      end
    end


    scenario 'tries to edit his question.', js: true do
      visit question_path question
      save_and_open_page
      within "#question_#{question.id}" do

        click_on 'Edit'
        fill_in 'Title', with: 'edited title'
        fill_in 'Question', with: 'edited body'
        click_on 'Save'
        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to have_content 'edited title'
        expect(page).to have_content 'edited question'
        expect(page).to_not have_selector 'textarea'
      end
    end


  end

  context 'Not authenticated user' do
    scenario 'tries to edit question.', js: true do
      visit question_path question

      expect(page).to_not have_link 'Edit'
    end
  end
end 