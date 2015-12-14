class CreateTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :name_indexed

      t.timestamps null: false
    end

    add_index :users, :name_indexed
  end
end
