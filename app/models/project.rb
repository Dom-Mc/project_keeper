class Project < ActiveRecord::Base
  belongs_to :user
  
  def slug
    self.name.downcase.gsub(/\s+/, '-')
  end

  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end

end
