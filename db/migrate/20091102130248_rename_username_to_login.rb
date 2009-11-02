class RenameUsernameToLogin < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.rename :username, :login
    end
  end

  def self.down
    change_table :users do |t|
      t.rename :login, :username
    end
  end
end
