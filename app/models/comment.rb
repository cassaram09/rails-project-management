class Comment < ActiveRecord::Base
  include DateTimeConverter
  extend KeywordSearch

  belongs_to :user
  belongs_to :task

  validates :content, presence: true

  scope :search, -> (search, user) { where("content LIKE ? AND user_id = ?", "%#{search}%", user.id)}

  def self.search(search, current_user_id)
     where("content LIKE ? AND user_id = ?", "%#{search}%", current_user_id)
  end
end
