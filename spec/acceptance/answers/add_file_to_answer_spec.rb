require 'acceptance/acceptance_helper.rb'

feature 'Add files to answer', %q{
In order to illustrate answer
As an author of answer
I would like to be able to attach file
} do

  given(:user) {create(:user)}
  given(:quetsion) {create(:question)}

  background do
    sugn_in user
    visit question_path question
  end

  scenario 'User adds file when creating the answer', js: true do

    fill_in 'Your Answer', with: "answer"
    attach_file "File", "#{Rails.root}/spec/spec_helper.rb"
    click_on "Create"

    within ".answers" do
      expect(page).to have_link 'spec_helper.rb', href: 'uploads/attachable/file/1/spec_helper.rb'
    end

  end


end