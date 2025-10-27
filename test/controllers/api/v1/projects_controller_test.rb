require "test_helper"

class Api::V1::ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project1 = projects(:project_one)
    @project2 = projects(:project_two)
  end
  test "should get title and optional description" do
    @project1.update(title: "Toto App")

    get api_v1_projects_url
    assert_includes @response.body, "Toto App"
    assert_includes @response.body, "Christmas App"
  end

  test "should get the project by the id" do
    get api_v1_project_url(@project1.id)

    response = JSON.parse(@response.body)
    assert_equal @project1.title, response["title"]
    assert_equal @project1.description, response["description"]
  end

  test "should get create" do
    get api_v1_projects_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_projects_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_projects_destroy_url
    assert_response :success
  end
end
