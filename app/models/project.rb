class Project < ActiveRecord::Base
  include PgSearch

 multisearchable :against => [ :name,
 								  :description,
 								  :location,
 								  :tags ]

# opts will be a hash: {sort_by: category, value: category value, year: year }.
# year will probably not be there in some cases..
# eg, to look up project by the Golden Bears, {sort_by: cohort, value: "Golden Bears", year: 2014}
	class << self
		def sort_by(opts)
			if opts[:sort] == "old"
				projects = Project.all.reverse
			elsif opts[:sort] == "location"
				self.sort_by_location(opts)
			elsif opts[:sort] == "tags"
				self.sort_by_tags(opts)
			elsif opts[:sort] == "cohort"
				self.sort_by_cohort(opts)
			elsif opts[:sort] == "year"
				self.sort_by_year(opts)
			else
				projects = Project.all
			end
		end

		# def sort_by(opts)
		# 	self.send("sort_by_#{opts[:sort_by]}",opts)
		# end

		def sort_by_location(opts)
			self.find(location: opts[:location])
		end

		def sort_by_tags(opts)
			# assumes value is an array of tags, eg ["JavaScript", "single page app"]
			opts[:value].map{ |tag| self.search_projects(tag) }
		end

		def sort_by_cohort(opts)
			result = self.where(opts[:value])
			result = result.sort_by_year(opts) if opts[:year]
		end

		def sort_by_year(opts)
			self.find(year: opts[:year].year)
		end

		# def search_projects(search_term)
		# 	PgSearch.multisearch(search_term)
		# end

	end


end

# 1. Full text search with pg_search gem
# 2. Sort by: location, tags, cohort, cohort end date
