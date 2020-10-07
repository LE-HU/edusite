class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_rich_text :description

  validates :title, :description, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: { :minimum => 5 }

  belongs_to :user

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
end
