require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @project = Project.new(title: "New Project", description: "Project Description", user: @user)
  end

  test "project belongs to user" do
    assert_equal @user, @project.user
  end
end
