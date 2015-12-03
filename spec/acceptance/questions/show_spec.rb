require 'rails_helper'

feature 'Show question and answers', %q{
  As a guest or a user
  I want to be able to view question and all the answers to it
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question)}

  scenario 'User can view question and all the answers to it`'  do
  sign_in user
  visit question_path(question)

    question.answers.each do |a|
      expect(page).to have_content a.body
     end
  end

  scenario 'Guest can view questions' do
    visit question_path(question)

    question.answers.each do |a|
      expect(page).to have_content a.body
    end
  end

end