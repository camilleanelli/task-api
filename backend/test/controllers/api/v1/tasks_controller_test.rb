require "test_helper"

class Api::V1::TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @existing_task = tasks(:one)
    @project = projects(:project_one)
  end
  test "should get index" do
    get api_v1_project_tasks_url(project_id: @project.id)
    assert_response :success
  end

  test "should get show" do
    get api_v1_task_url(tasks(:one).id)
    assert_response :success
  end

  test "should create a task and return success" do
    assert_difference("Task.count") do
      post api_v1_project_tasks_url(project_id: @project.id), params: { task: { title: "New Task", description: "Task description", status: "pending" } }
    end
    assert_response :success
  end

  test "should render an error when creating without title" do
    post api_v1_project_tasks_url(project_id: @project.id), params: { task: { title: "", description: "Task description", status: "pending" } }
    assert_response :unprocessable_entity
  end

  test "should update a task and return success" do
    patch api_v1_project_task_url(id: @existing_task.id, project_id: @project.id), params: { task: { title: "Updated Task", description: "Updated description", status: "in_progress" } }
    assert_response :success
  end

  test "should destroy a task" do
    delete api_v1_project_task_url(id: @existing_task.id, project_id: @project.id)
    assert_response :success
  end
end
