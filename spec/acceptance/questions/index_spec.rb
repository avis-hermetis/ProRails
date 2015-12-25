require '/home/rubyman/Rails/qna/spec/acceptance/acceptance_helper'

feature 'View questions', %q{
  As a guest or a user
  I want to be able to see the questions
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:questions) { create_list(:question, 2)}

  scenario 'User can view questions'  do
    sign_in user
    visit questions_path

    questions.each do |q|
      expect(page).to have_content q.title
    end
  end

  scenario 'User can open question' do
    sign_in user
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'Guest can view questions' do
    visit questions_path

    questions.each do |q|
      expect(page).to have_content q.title
    end
  end

  scenario 'Guest can open question' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end
end