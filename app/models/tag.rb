class Tag < ActiveRecord::Base
  has_many :task_tags
  has_many :tasks, through: :task_tags
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  def self.search(search, current_user_id)
     where("name LIKE ? AND user_id = ?", "%#{search}%", current_user_id)
  end
end
