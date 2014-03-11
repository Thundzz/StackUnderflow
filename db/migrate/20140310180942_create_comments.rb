class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.column :contents, :string, :limit => 400
      t.column :parent_id, :integer
      t.column :user_id, :integer
      t.column :question_id, :integer
      t.column :answer_id, :integer
      t.column :type, :string
    end
  end

  def down
    drop_table :comments
  end
end