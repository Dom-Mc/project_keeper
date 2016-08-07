class Project < ActiveRecord::Base

  belongs_to :user
  DATE_REGEX = /\d{1,2}[-]\d{1,2}[-]\d{2,4}/i

  validates :date_completed, :deadline, format: { with:  DATE_REGEX },
                                        allow_nil: true

  validates :description, :notes, length: { maximum: 255 },
                                  allow_nil: true

  validates :name, presence: true,
                   length: { maximum: 50 }

  validates :date_started, presence: true,
                           format: { with:  DATE_REGEX }

  validates :status, presence: true,
                     inclusion: { in: ["In Progress", "On Hold", "Completed"] }

  def slug
    self.name.downcase.gsub(/\s+/, '-')
  end

  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end

end
