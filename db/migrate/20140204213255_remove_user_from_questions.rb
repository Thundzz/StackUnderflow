class RemoveUserFromQuestions < ActiveRecord::Migration
  def up
    remove_column :questions, :user_id
  end

  def down
    add_column :questions, :user_id, :integer
  end
end
