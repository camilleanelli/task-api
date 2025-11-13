require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @project = projects(:project_one)
    @task = Task.new(title: "Implement feature X", description: "Detailed description of feature X", status: :in_progress, project: @project)
  end

  test "task belongs to project" do
    assert_equal @project, @task.project
  end

  test "should not save task without title" do
    @task.title = ""
    assert_not @task.save, "Saved the task without a title"
  end
end
