require 'acceptance/acceptance_helper.rb'

feature 'Add files to question', %q{
In order to illustrate question
As an author of question
I would like to be able to attach file
} do

  given(:user) {create(:user)}

  background do
    sign_in user
    visit new_question_path
  end

  scenario 'User adds file when creating the question' do
    fill_in 'Title', with: "Test question"
    fill_in 'Body', with: "text text text"
    attach_file "File", "#{Rails.root}/spec/spec_helper.rb"
    click_on "Create"

    expect(page).to have_link 'spec_helper.rb', href: 'uploads/attachable/file/1/spec_helper.rb'
  end


end