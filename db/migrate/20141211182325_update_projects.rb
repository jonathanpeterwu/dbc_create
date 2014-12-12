class UpdateProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :extra_link, :string
  end
end
