def login_helper(email, password)
  visit '/login'
  fill_in 'user[email]',  :with => email
  fill_in 'user[password]',   :with => password
  click_button('Login')
  expect(page).to have_content 'You are now loged in'
end
