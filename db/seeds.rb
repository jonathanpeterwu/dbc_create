# Project.create(name: "test", description: "goodbye", source_url: "http://www.google.com", production_url: "http://www.github.com")
# Project.create(name: "test1", description: "goodbye1", source_url: "http://www.google.com", production_url: "http://www.github.com")
# Project.create(name: "test2", description: "goodbye2", source_url: "http://www.google.com", production_url: "http://www.github.com")
# Project.create(name: "test3", description: "goodbye3", source_url: "http://www.google.com", production_url: "http://www.github.com")
# Project.create(name: "test4", description: "goodbye4", source_url: "http://www.google.com", production_url: "http://www.github.com")
# Project.create(name: "test5", description: "goodbye5", source_url: "http://www.google.com", production_url: "http://www.github.com")
# Project.create(name: "sf", description: "sf goodbye", source_url: "http://www.google.com", production_url: "http://www.github.com", location: "San Francisco")

AppRoot = File.expand_path(File.dirname(__FILE__))

f = File.open(File.join(AppRoot, "seed_data.csv"), "r")
f.each_line do |line|
	project = line.split(',')
	Project.create(name: project[1], description: project[6], source_url: project[4], production_url: project[3], location: project[-1], tags: "final_project", image_url: project[5], team_member: project[-2])
	p project
end
f.close
