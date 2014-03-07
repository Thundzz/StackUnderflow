class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :score
      t.integer :question_id
      t.boolean :validated

      t.timestamps
    end
  end
end
