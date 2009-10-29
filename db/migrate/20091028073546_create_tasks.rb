class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :short
      t.string :task
      t.boolean :complete

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
