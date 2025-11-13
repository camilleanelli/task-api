require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  def setup
    @owner = owners(:owner_one)
    @user = @owner.user
    @project = Project.new(title: "New Project", description: "Project Description", owner: @owner)
  end

  test "project belongs to owner" do
    assert_equal @owner, @project.owner
  end

  test "project has a user through owner" do
    owner = owners(:owner_one)
    project = Project.new(title: "Another Project", description: "Another Description", owner: owner)
    assert_equal owner.user, project.user
  end
end
