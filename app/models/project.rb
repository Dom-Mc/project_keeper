class Project < ActiveRecord::Base

  belongs_to :user
  DATE_REGEX = /\d{4}[-]\d{2}[-]\d{2}/

  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: { scope: :user_id,
                     message: "Please choose a different project name, '{value}' is already in use." }

 validates :status, presence: true,
                    inclusion: { in: ["In Progress", "On Hold", "Completed"] }

  validates :date_started, :date_completed, :deadline, format: { with:  DATE_REGEX,
                                              message: 'must be a valid date.',
                                              allow_blank: true }

  validates :description, :notes, length: { maximum: 255 },
                                    allow_blank: true

  def slug
    self.name.downcase.gsub(/\s+/, '-')
  end

  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end

end
