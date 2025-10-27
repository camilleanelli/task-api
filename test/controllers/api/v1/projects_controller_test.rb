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
    assert_equal @project1.user_id, response["user_id"]
  end

  test "should create a project with valid params" do
    assert_difference("Project.count") do
      post api_v1_projects_url, params: { project: { title: "New Project", description: "Project Description", user_id: @project1.user_id } }
    end
    assert_response :success
  end

  test "should render an error when creating without title" do
    post api_v1_projects_url, params: { project: { title: "", description: "Project Description", user_id: @project1.user_id } }
    assert_response :unprocessable_entity
  end

  test "should update the project with valid params" do
    patch api_v1_project_url(@project1.id), params: { project: { title: "Updated Project", description: "Updated Description" } }
    assert_response :success
    assert_equal "Updated Project", JSON.parse(@response.body)["title"]
    assert_equal "Updated Description", JSON.parse(@response.body)["description"]
  end

  test "should render an error when updating with invalid params" do
    patch api_v1_project_url(@project1.id), params: { project: { title: "" } }
    assert_response :unprocessable_entity
  end

  test "should delete the project" do
    assert_difference("Project.count", -1) do
      delete api_v1_project_url(@project1.id)
    end
    assert_response :no_content
  end
end
