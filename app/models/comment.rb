class Comment < ActiveRecord::Base
  include DateTimeConverter

  belongs_to :user
  belongs_to :task

  validates :content, presence: true

end
