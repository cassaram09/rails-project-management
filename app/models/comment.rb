class Comment < ActiveRecord::Base
  include DateTimeConverter
  belongs_to :user
  belongs_to :task

  validates :content, presence: true

  def self.search(search)
     where("content LIKE ?", "%#{search}%") 
  end
end
