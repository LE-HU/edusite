class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }
  has_rich_text :content

  validates :title, :content, :course, presence: true
  belongs_to :course, counter_cache: true
  has_many :user_lessons, dependent: :destroy

  def to_s
    title
  end

  def viewed(user)
    self.user_lessons.where(user: user).present?
  end
end
