class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :right
      t.string :name
      t.string :lastname
      t.integer :study
      t.integer :points
      t.string :email
      t.string :login

      t.timestamps
    end
  end
end
