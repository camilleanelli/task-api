class AddUserToProject < ActiveRecord::Migration[7.2]
  def change
    add_reference :projects, :user, null: false, foreign_key: true
  end
end
