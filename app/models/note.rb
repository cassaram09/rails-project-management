class Note < ActiveRecord::Base
  include DateTimeConverter
  belongs_to :user

  validates :content, :title, presence: true

  def self.search(search)
    where("title LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%") 
  end

end
