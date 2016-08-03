class Note < ActiveRecord::Base
  include DateTimeConverter

  belongs_to :project
  belongs_to :user

  validates :title, :content, presence: true 

end
