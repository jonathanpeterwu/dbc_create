class Project < ActiveRecord::Base

  def validate_links
    valid_links = [self.production_url, self.source_url].map do |link|
       unless link.match(/^https?:\/\//)
        "https://" + link
      end
    end
    self.production_url, self.source_url = valid_links[0], valid_links[1]
  end

end

