require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
  end
  test "should return users info" do
    get api_v1_users_url
    assert_response :success
    assert_includes @response.body, @user1.email
    assert_includes @response.body, @user1.name
    assert_includes @response.body, @user1.last_name
  end

  # test "should create user with valid params" do
  #   post api_v1_users_create_url
  #   assert_response :success
  # end

  # test "should return error with invalid params" do
  #   post api_v1_users_create_url
  #   assert_response :success
  # end
end
