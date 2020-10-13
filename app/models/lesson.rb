class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }

  validates :title, :content, :course, presence: true
  belongs_to :course

  def to_s
    title
  end
end
