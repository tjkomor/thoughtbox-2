require 'test_helper'

class UserCanEditLinkTest < ActionDispatch::IntegrationTest

  test "user can edit link" do
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

    click_link "Edit"

    fill_in "Title", with: "coooool"
    fill_in "Url", with: "http://espn.go.com"

    click_button "Update Link"

    assert page.has_content?('coooool')
  end
end
