module AcceptanceMacros
  def sign_in(user)
    visit new_user_session_path #используем DSL capybara(visit). Можно использовать хелперы, можно url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
end