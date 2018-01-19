class UpdateProjectsModel < ActiveRecord::Migration[4.2]
  def change
  	add_column :projects, :answer1, :text
  	add_column :projects, :answer2, :text
  	add_column :projects, :answer3, :text
  	add_column :projects, :answer4, :text
  end
end
