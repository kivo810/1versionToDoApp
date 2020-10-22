class Tag < ApplicationRecord
  belongs_to :user, required: true
  has_many :tag_assocations, dependent: :destroy
  has_many :tasks, through: :tag_assocations

  validates :title, presence: true
  validates :color, presence: true
end
