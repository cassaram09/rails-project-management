class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  validates :content, presence: true
end
