class Note < ActiveRecord::Base
  belongs_to :user

  validates :content, :name, presence: true

end
