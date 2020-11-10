class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  has_many :tag_associations, dependent: :destroy
  has_many :tags, :through => :tag_associations

  validates :title, presence: true

  scope :pending, -> { where( is_done: false) }
  scope :completed, -> { where( is_done: true) }

  scope :by_category, -> (category) { where("category_id = ?", category)}
  # scope :by_tags, -> (tags) { where(:tags => tags)}
  scope :by_tags, -> (tag_ids) { joins( tag_associations: :tag).where("tag_id IN (?)", tag_ids)}
  # scope :by_category_and_tags, -> (category,tags) {
  #   where(:category_id => category, :tags => tags)
  # }
end
