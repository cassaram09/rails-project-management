class Note < ActiveRecord::Base
  include DateTimeConverter
  belongs_to :user

  validates :content, :name, presence: true

end
