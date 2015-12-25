require '/home/rubyman/Rails/qna/spec/acceptance/acceptance_helper'

feature 'User sign out', %q{
  As an user
  I want to be able to sign out
} do
  given(:user) { create(:user) }

  scenario "Registered user try to sign out" do
    sign_in user

    click_on "Sign out"

    expect(page).to have_content("Signed out successfully.")
    expect(page).to_not have_link("Sign out")
    expect(page).to have_link("Sign In")
  end

  scenario "Not registered user try to sign out" do
    visit root_path
    expect(page).to_not have_link("Sign out")
    expect(page).to have_link("Sign In")
  end
end