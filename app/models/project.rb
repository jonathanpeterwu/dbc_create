class Project < ActiveRecord::Base
  include PgSearch

 validates :name, :description, :production_url, :source_url, :location, :image_url, presence: true

 multisearchable :against => [ :name,
 							  	  :description,
 								  :location,
 								  :tags ]

	class << self
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
    valid_links = [self.production_url, self.source_url, self.image_url].map do |link|
      unless link.match(/^https?:\/\//)
        "https://" + link
      else
      	link
      end
    end
    self.production_url, self.source_url, self.image_url= valid_links[0], valid_links[1], valid_links[2]
  end

  def validate_img_url
  	unless self.image_url.match(/^.*\.jpg|^.*\.png/)
  		self.image_url += ".png"
  	else
  		self.image_url
  	end
  	self.image_url
  end

end

# 1. Full text search with pg_search gem
# 2. Sort by: location, tags, cohort, cohort end date
