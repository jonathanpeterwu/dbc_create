class UpdateProjects < ActiveRecord::Migration[4.2]
  def change
  	add_column :projects, :extra_link, :string
  end
end
