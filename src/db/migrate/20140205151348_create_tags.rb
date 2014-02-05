class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :mot_clef

      t.timestamps
    end
  end
end
