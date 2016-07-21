class Note < ActiveRecord::Base
  include DateTimeConverter
  extend KeywordSearch

  belongs_to :user

  validates :content, :title, presence: true

  scope :search, -> (search, user) { where("(title LIKE ? OR content LIKE ? ) AND user_id = ?", "%#{search}%", "%#{search}%", user.id)}

end
