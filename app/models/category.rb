class Category < ApplicationRecord
  belongs_to :user, required: true
  has_many :tasks

  validates :title, presence: true
  validates :color, presence: true
end
