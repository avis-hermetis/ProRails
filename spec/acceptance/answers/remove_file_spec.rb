require 'acceptance/acceptance_helper'

feature 'User removes the attachment from his answer', %q{
  As a authenticated user
  I want to be able to remove the attachment only for my answer
} do
  given!(:user) {create(:user)}
  given!(:other_user) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer,question: question, user: user)}
  given!(:file) {create(:attachment, attachable: answer)}




  scenario 'Not authenticated user does not see the "Delete file" link' do
    visit question_path user.questions.first.id
    within ".answers" do
      save_and_open_page
      expect(page).to have_content file.file_name
      expect(page).to_not have_link 'Delete file'
    end
  end

  context 'Authenticated user' do

    scenario 'not the auther of answer tries do not see the "Delete file" link', js: true do
      sign_in other_user
      visit question_path question
      within '.answers' do
        expect(page).to have_link 'spec_helper.rb'
        expect(page).to_not have_link 'Delete file'
      end
    end

    scenario 'the auther of answer tries to remove attachment', js:true do
      sign_in user
      visit question_path question
      within '.answers'do
        expect(page).to have_link 'spec_helper.rb'
        expect(page).to have_link 'Delete file'

        click_on 'Delete file'
        expect(page).to_not have_link 'spec_helper.rb'
      end
    end
  end


end