class CreateBadges < ActiveRecord::Migration
	def change
		create_table :badges do |t|

			t.string :name
			t.string :official_name
			t.string :description
			t.string :metal
			t.timestamps
		end
	end
end
