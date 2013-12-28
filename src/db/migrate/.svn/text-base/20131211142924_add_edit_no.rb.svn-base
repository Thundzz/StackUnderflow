class AddEditNo < ActiveRecord::Migration
  def up
  		add_column :posts, :editionNo, :integer
  		@posts = Post.all
		@posts.each do |post|
			post.editionNo = 0
			post.save()
		end

  end

  def down
  	remove_column :posts, :editionNo
  end

end
