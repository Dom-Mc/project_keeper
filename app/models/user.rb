class User < ActiveRecord::Base

  has_many :projects
  has_secure_password
  EMAIL_REGEX = /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

  before_save :alter_user_input
  before_create :alter_user_input
  before_update :alter_user_input

  validates :first_name, :last_name, presence: true,
                                     length: { maximum: 30 }

  validates :email, length: { maximum: 200 },
                    format: { with: EMAIL_REGEX },
                    allow_nil: true

  validates :username, presence: true,
                       uniqueness: true,
                       length: { in: 3..25 },
                       exclusion: { in: %w(admin administrator root),
                         message: "%{value} is reserved." }

  validates :password, length: { in: 6..15 },
                       presence: true,
                       on: :save

  validates :password, length: { in: 6..15 },
                       allow_nil: true,
                       on: :update

  private

    def alter_user_input
      self.username = username.downcase
      self.email = email.downcase
      self.first_name = first_name.capitalize
      self.last_name = last_name.capitalize
    end

end
