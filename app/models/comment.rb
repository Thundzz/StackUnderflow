# coding: utf-8 

class Comment < ActiveRecord::Base
	attr_accessible  :contents, :parent_id
	belongs_to :user
	

	def store_id (id)
		self.parent_id = id
	end
end
