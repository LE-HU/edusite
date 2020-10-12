class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :content, :course, presence: true
  belongs_to :course
end
