class UpdateVotes < ActiveRecord::Migration
  def change
  	add_column :projects, :vote, :integer, :default => 0
  end
end
