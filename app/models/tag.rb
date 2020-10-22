class Tag < ApplicationRecord
  belongs_to :user, required: true
  has_many :tag_associations, dependent: :destroy
  has_many :tasks, through: :tag_associations

  validates :title, presence: true
  validates :color, presence: true
end
