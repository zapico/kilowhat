class Addingsessionid < ActiveRecord::Migration
  def self.up
     add_column :logs, :session, :string
  end

  def self.down
  end
end
