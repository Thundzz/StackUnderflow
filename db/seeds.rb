# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


	Badge.init_db
	User.create(:login => "bob")
	for i in 0..50
		Question.create(:content => "I am a test question", :score=> 10, :title => "Hello ?", :user => User.find_by_login("bob"), :views => 0)		
	end
	Question.create(:content => "I am a test question", :score=> 10, :title => "Hello ?", :user => User.find_by_login("bob"), :views => 0)