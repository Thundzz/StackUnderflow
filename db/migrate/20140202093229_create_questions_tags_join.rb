class CreateQuestionsTagsJoin < ActiveRecord::Migration
  def up

   create_table 'questions_tags' , :id => false do |t|
      t.column 'question_id', :integer
      t.column 'tag_id', :integer
    end


  end

  def down
   drop_table 'questions_tags'
  end
end
