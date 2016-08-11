class Project < ActiveRecord::Base

  belongs_to :user
  DATE_REGEX = /\d{4}[-]\d{2}[-]\d{2}/

  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: { scope: :user_id,
                     message: "'%{value}' is already in use. Please choose a different project name." }

 validates :status, presence: true,
                    inclusion: { in: ["In Progress", "On Hold", "Completed"] }

  validates :date_started, :date_completed, :deadline, format: { with:  DATE_REGEX,
                                              message: 'must be in a valid format.',
                                              allow_blank: true }

  validates :description, :notes, length: { maximum: 1500 },
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
