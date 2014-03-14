# coding: utf-8 

class Comment < ActiveRecord::Base
	attr_accessible  :contents, :parent_id, :user
	belongs_to :user

	validates :contents, presence: true
	validates :user, presence: true
	

	def store_id (id)
		self.parent_id = id
	end
end
