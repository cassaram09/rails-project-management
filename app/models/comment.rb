class Comment < ActiveRecord::Base
  include DateTimeConverter
  belongs_to :user
  belongs_to :task

  validates :content, presence: true

  def self.search(search, current_user_id)
     where("content LIKE ? AND user_id = ?", "%#{search}%", current_user_id)
  end
end
