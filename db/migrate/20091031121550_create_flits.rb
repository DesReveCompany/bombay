class CreateFlits < ActiveRecord::Migration
  def self.up
    create_table :flits do |t|
      t.integer :user_id, :null => false
      t.string :message, :null => false
      t.datetime :created_at, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :flits
  end
end
