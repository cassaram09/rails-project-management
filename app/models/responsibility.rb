class Responsibility < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :tags

  enum status: [:active, :complete]
end
