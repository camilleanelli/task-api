require "test_helper"

class OwnerTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @owner = Owner.new(user: @user)
  end

  test "owner belongs to user" do
    assert_equal users(:one), @owner.user
  end
end
