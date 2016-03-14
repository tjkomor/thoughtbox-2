require 'test_helper'

class UserCanAddLinkTest < ActionDispatch::IntegrationTest

  test "link is created" do
    user = User.create(email: "tyler@tyler.com", password: "password")
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Login"
    fill_in "Title", with: "ESPN"
    fill_in "Url", with: "http://espn.go.com"

    click_button "Create New Link"

    assert_equal links_path, current_path

    assert page.has_content?("ESPN")
  end

  test "title can't be blank" do
    user = User.create(email: "tyler@tyler.com", password: "password")
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Login"
    fill_in "Url", with: "cooooooool"
    click_button "Create New Link"

    assert_equal links_path, current_path
  end
end
