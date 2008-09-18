class DropDownTitle < ActiveRecord::Migration
  def self.up
    add_column :pages, :menu_name, :text, :default => ""
  end

  def self.down
    remove_column :pages, :menu_name
  end
end
