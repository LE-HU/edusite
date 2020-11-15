class Course < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_rich_text :description

  validates :title, :description, :short_description, :language, :price, :level, presence: true
  validates :title, uniqueness: true
  validates :description, presence: true, length: { :minimum => 5 }

  belongs_to :user, counter_cache: true
  has_many :lessons, dependent: :destroy
  has_many :enrollments

  scope :latest, -> { order(created_at: :desc).limit(3) }
  scope :top_rated, -> { order(average_rating: :desc, created_at: :desc).limit(3) }
  scope :popular, -> { order(enrollments_count: :desc, created_at: :desc).limit(3) }

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
end
