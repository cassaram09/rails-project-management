class Note < ActiveRecord::Base
  include DateTimeConverter
  belongs_to :user

  validates :content, :title, presence: true

  def self.search(search, current_user_id)
     where("(title LIKE ? OR content LIKE ?) AND user_id = ?", "%#{search}%", "%#{search}%", current_user_id)
  end

end
