class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }
  has_rich_text :content

  validates :title, :content, :course, presence: true
  belongs_to :course, counter_cache: true
  #Course.find_each { |course| Course.reset_counters(course.id, :lessons) }

  def to_s
    title
  end
end
