class Course < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_rich_text :description

  validates :title, :description, :short_description, :language, :price, :level, presence: true
  validates :title, uniqueness: true, length: { maximum: 70 }
  validates :description, presence: true, length: { minimum: 5, maximum: 2000 }
  validates :short_description, presence: true, length: { maximum: 140 }
  validates :avatar, content_type: ["image/png", "image/jpg", "image/jpeg"], size: { less_than: 1.megabyte, message: "Allowed file size < 1 Mb" }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user, counter_cache: true
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :restrict_with_error
  has_many :user_lessons, through: :lessons
  has_many :course_tags, inverse_of: :course, dependent: :destroy
  has_many :tags, through: :course_tags
  has_one_attached :avatar

  scope :latest, -> { order(created_at: :desc).limit(3) }
  scope :top_rated, -> { order(average_rating: :desc, created_at: :desc).limit(3) }
  scope :popular, -> { order(enrollments_count: :desc, created_at: :desc).limit(3) }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }

  def to_s
    title
  end

  LANGUAGES = ["English", "Polish", "Russian", "Spanish"]
  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  LEVELS = ["Beginner", "Intermediate", "Advanced"]
  def self.levels
    LEVELS.map { |level| [level, level] }
  end

  def bought(user)
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).present?
  end

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0.0)
    end
  end

  def progress(user)
    unless self.lessons_count == 0
      user_lessons.where(user: user).count / self.lessons_count.to_f * 100
    end
  end
end
