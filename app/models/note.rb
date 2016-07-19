class Note < ActiveRecord::Base
  include DateTimeConverter
  belongs_to :user

  validates :content, :title, presence: true

end
