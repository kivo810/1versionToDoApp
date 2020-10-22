class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  has_many :tag_assocations, dependent: :destroy
  has_many :tags, :through => :tag_assocations

  validates :title, presence: true
end
