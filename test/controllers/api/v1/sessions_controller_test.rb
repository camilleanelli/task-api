require "test_helper"

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should login with valid credentials" do
    post api_v1_login_url, params: { email: @user.email, password: "password123" }
    assert_response :success
  end

  test "should return a token" do
    post api_v1_login_url, params: { email: @user.email, password: "password123" }
    json_response = JSON.parse(@response.body)
    assert_not_nil json_response["token"]
  end

  test "should not login with invalid credentials" do
    post api_v1_login_url, params: { email: @user.email, password: "wrongpassword" }
    assert_response :unauthorized
  end

  test "should logout successfully" do
    delete api_v1_logout_url
    assert_response :success
  end
end
