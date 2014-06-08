class Project < ActiveRecord::Base

# opts will be a hash: {sort_by: category, value: category value, year: year }.
# year will probably not be there in some cases..
# eg, to look up project by the Golden Bears, {sort_by: cohort, value: "Golden Bears", year: 2014}
	class << self
		def sort_by(opts)
			self.send("sort_by_#{opts[:sort_by]}",opts)
		end

		def sort_by_location(opts)
			self.find(location: opts[:value])
		end

		def sort_by_tags(opts)
			# assumes value is an array of tags, eg ["JavaScript", "single page app"]
			# 
			opts[:value].map{ |tag| self.find(tag: tag) }
		end

		def sort_by_cohort(opts)
			result = self.where(opts[:value])
			result = result.sort_by_year(opts) if opts[:year]
		end

		def sort_by_year(opts)
			self.find(year: opts[:year].year)
		end
	end

end

# 1. Full text search with pg_search gem
# 2. Sort by: location, tags, cohort, cohort end date




