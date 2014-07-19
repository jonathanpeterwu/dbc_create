class Project < ActiveRecord::Base

  include PgSearch

 validates :name, :description, :production_url, :source_url, :location, :image_url, presence: true

 multisearchable :against => [ :name,
 							  	  :description,
 								  :location,
 								  :tags ]

	class << self
		# def sort_by(opts)
		# 	if opts[:sort][:old]
		# 		projects = Project.all.reverse
		# 	elsif opts[:sort][:location]
		# 		self.sort_by_location(opts)
		# 	elsif opts[:sort] == "tags"
		# 		self.sort_by_tags(opts)
		# 	elsif opts[:sort] == "cohort"
		# 		self.sort_by_cohort(opts)
		# 	elsif opts[:sort] == "year"
		# 		self.sort_by_year(opts)
		# 	elsif opts[:sort] == "chicago"
		# 		projects = Project.where(location: "Chicago")
		# 		p projects
		# 	elsif opts[:sort] == "sanfrancisco"
		# 		projects = Project.where(location: "San Francisco")
		# 		p projects
		# 	elsif opts[:sort] == "newyork"
		# 		projects = Project.where(location: "New York")
		# 		p projects
		# 	else
		# 		projects = Project.all
		# 	end
		# end

		# Using buttons for our sorts, params comes in like so:
		# opts = {"sort" => {"location"=>"San Francisco"}}
		def sort_by(opts)
			opts = opts["sort"]
			key = opts.keys[0]
			self.send("sort_by_#{key}",opts)
			# Project.where(opts[:sort].to_sym => opts[:value])
		end

		def sort_by_location(opts)
			self.where(opts)
		end

		def sort_by_cohort(opts)
			self.where(cohort: opts[:value])
		end

		def search_projects(search_term)
			PgSearch.multisearch(search_term).map { |result| Project.find(result.searchable_id)  }
		end

	end

  def validate_links
    valid_links = [self.production_url, self.source_url].map do |link|
      unless link.match(/^https?:\/\//)
        "https://" + link
      else
      	link
      end
    end
    self.production_url, self.source_url = valid_links[0], valid_links[1]
  end

end

# 1. Full text search with pg_search gem
# 2. Sort by: location, tags, cohort, cohort end date
