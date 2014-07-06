class CreateProjects < ActiveRecord::Migration
  def change
  	create_table :projects do |t|
  		t.string :name
  		t.text   :description
  		t.string :production_url
  		t.string :source_url
  		t.string :location
  		t.string :tags
  		t.string :image_url
      t.string :team_member
  	end
  end
end
