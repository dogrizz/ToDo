class AddPriorityAtToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :priority, :int
  end

  def self.down
    remove_column :tasks, :priority
  end
end
