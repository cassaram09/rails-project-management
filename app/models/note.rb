class Note < ActiveRecord::Base
  include DateTimeConverter
  extend KeywordSearch

  belongs_to :project
  belongs_to :user

  validates :content, :title, presence: true

end
