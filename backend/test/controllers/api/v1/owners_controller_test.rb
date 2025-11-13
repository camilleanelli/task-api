require "test_helper"

class OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = owners(:owner_one)
  end
  test "should get index owners with user name" do
    get api_v1_owners_url
    assert_response :success
    assert_includes @response.body, @owner.user.entire_name
  end
end
