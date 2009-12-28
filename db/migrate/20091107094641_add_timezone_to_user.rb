class AddTimezoneToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :timezone, :string
    add_column :users, :language, :string
    add_column :users, :bio,      :string
    add_column :users, :image_filename, :string
  end

  def self.down
    remove_column :users, :timezone
  end
end
