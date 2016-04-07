require 'acceptance/acceptance_helper.rb'

feature 'Add files to answer', %q{
In order to illustrate answer
As an author of answer
I would like to be able to attach file
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question)}
  #given!(:answer) {create(:answer)}

  background do
    sign_in user
    visit question_path(question)
  end

  scenario 'User adds file when creating the answer', js: true do
    fill_in 'Your Answer', with: "answer"
    attach_file "File", "#{Rails.root}/spec/spec_helper.rb"
    click_on "Create answer"

    within ".attachment li#attachment-1" do
      expect(page).to have_link 'spec_helper.rb'
    end

  end

end
