class ChangeUserToOwnerInProjects < ActiveRecord::Migration[7.2]
  def change
    remove_reference :projects, :user, foreign_key: true
    add_reference :projects, :owner, null: false, foreign_key: true
  end
end
