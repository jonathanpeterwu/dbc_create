class UpdateVotes < ActiveRecord::Migration[4.2]
  def change
  	add_column :projects, :vote, :integer, :default => 0
  end
end
