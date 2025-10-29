require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
  end
  test "should return users emails and id" do
    get api_v1_users_url
    assert_response :success
    assert_includes @response.body, @user1.email
    assert_includes @response.body, @user1.id.to_s
  end

  # test "should create user with valid params" do
  #   assert_difference("User.count") do
  #     post api_v1_users_url, params: { user: { name: "New", last_name: "User", email: "new_user@example.com" } }
  #   end
  #   assert_response :created
  #   json_response = JSON.parse(@response.body)
  #   assert_includes json_response.values, "New"
  #   assert_includes json_response.values, "User"
  #   assert_includes json_response.values, "new_user@example.com"
  # end

  # test "should return error with invalid params" do
  #   post api_v1_users_url, params: { user: { name: "", last_name: "User", email: "invalid_email" } }
  #   assert_response :unprocessable_entity
  # end
end
