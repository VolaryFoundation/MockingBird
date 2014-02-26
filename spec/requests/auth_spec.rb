require 'spec_helper.rb'

describe "Auth System" do
  it 'should reject bad email or password' do
    visit '/login'
    expect(page).to have_content 'Reset Password'
    fill_in 'user[email]',  :with => 'test@example.com'
    fill_in 'user[password]',   :with => '!QAZxsw2'
    click_button('Login')
    expect(page).to have_content 'Invalid email or password'
  end

  it 'should login in a valid user' do
    user = create :user
    visit '/login'
    fill_in 'user[email]',  :with => user.email
    fill_in 'user[password]',   :with => user.password
    click_button('Login')
    expect(page).to have_content 'You are now loged in'
    expect(page).to have_content user.email
  end
end
