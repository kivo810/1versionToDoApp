class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :preset_objects

  has_many :categories
  has_many :tasks
  has_many :tags

  validates :email, presence: true
  validates :username, presence: true

  private
  def preset_objects
    Task.create! :title => "Toto je jednoduchy ukol", :note => "", :user_id => self.id, :is_done => false
    Task.create! :title => "Toto je uz dokonceny ukol", :note => "", :user_id => self.id, :is_done => true
    cat1 = Category.create! :title => "Private", :user_id => self.id, :color => "blue"
    tag1 = Tag.create! :title => "Nakupy", :user_id => self.id, :color => "purple"
    task = Task.create! :title => "Nakoupit na veceri", :note => "", :user_id => self.id, :category => cat1
    task.tags << tag1
    task.save!
  end
end
