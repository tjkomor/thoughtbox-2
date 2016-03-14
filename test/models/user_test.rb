require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email must be unique" do
   user1 = User.create(email: 'tyler@tyler.com', password: 'password')
   user2 = User.new(email: 'tyler@tyler.com', password: 'password')
   assert user1.valid?
   refute user2.valid?
 end
end
