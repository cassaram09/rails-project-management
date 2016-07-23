class Comment < ActiveRecord::Base
  include DateTimeConverter
  include IndexCheck

  belongs_to :user
  belongs_to :task

  validates :content, presence: true

end
