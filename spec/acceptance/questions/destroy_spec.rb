require 'acceptance/acceptance_helper'

feature 'User destroys his question', %q{
  As a authenticated user
  I want to be able to delete only my question
} do

  given(:other_user) {create(:user)}
  given!(:question) {create(:question)}
  scenario 'Authenticated user deletes his question' do
    sign_in question.user
    visit question_path(question)

    click_on 'Delete question'
    expect(page).to_not have_content question.title
    expect(current_path).to eq questions_path
  end

  scenario 'Authenticated user deletes not his question' do
    sign_in other_user
    visit question_path(question)

    expect(page).to_not have_button 'Delete question'
  end

  scenario 'Guest deletes not his question' do
    visit question_path(question)

    expect(page).to_not have_button 'Delete question'
  end
end
