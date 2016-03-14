require 'test_helper'

class UserCanLoginTest < ActionDispatch::IntegrationTest

  test "User successfully creates account" do
    users_count = User.count
    visit login_path
    click_link "Create Account"
    fill_in "Email", with: "tyler@tyler.com"
    fill_in "Password", with: "password"
    fill_in "Confirmation", with: "password"
    click_button "Create Account"

    assert_equal links_path, current_path
    assert_equal users_count + 1, User.count
  end

  test "User email is already taken" do
    users_count = User.count
    user = User.create(email: "tyler@something.com", password: "password")
    visit new_user_path

    fill_in "Email", with: "tyler@something.com"
    fill_in "Password", with: "password"
    fill_in "Confirmation", with: "password"
    click_button "Create Account"

    assert_equal '/users', current_path
    assert page.has_content?("Email has already been taken")
  end

  test "User doesn't enter a password" do
    users_count = User.count
    visit '/users/new'

    fill_in "Email", with: "test@example.com"
    click_button "Create Account"

    assert_equal '/users', current_path
    assert page.has_content?("Password can't be blank")
    assert_equal users_count, User.count
  end

  test "User password and confirmation does not match" do
    users_count = User.count
    visit '/users/new'

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password1"
    fill_in "Confirmation", with: "password"
    click_button "Create Account"

    assert_equal '/users', current_path
    assert page.has_content?("Confirmation does not match password")
    assert_equal users_count, User.count
  end
end
