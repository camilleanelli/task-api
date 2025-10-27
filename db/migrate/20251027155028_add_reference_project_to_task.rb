class AddReferenceProjectToTask < ActiveRecord::Migration[7.2]
  def change
    add_reference :tasks, :project, null: false, foreign_key: true
  end
end
