require 'spec_helper.rb'

describe "Group Edit" do
  before do
    @group = create :group
    @user = create :admin
    login_helper(@user.email, @user.password)
    visit "/groups/#{@group.id}"
  end

  it 'should switch to main info edit when link is clicked', vcr: true, js: true do
    page.should have_selector(:link_or_button, 'Edit fields here')
    page.should have_css('section#mockingbird_edit', visible: false)
    click_link('Edit fields here')
    page.should have_css('section#mockingbird_edit', visible: true)
  end

  it 'should update the page after main info submit', vcr: true, js: true
end
