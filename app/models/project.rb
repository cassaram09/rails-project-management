class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_many :tags, through: :tasks
  has_many :comments, through: :tasks
  enum status: [:active, :on_hold, :complete]

  scope :complete, -> { where(status: 2) }
  scope :on_hold, -> { where(status: 1) }
  scope :active, -> { where(status: 0)}

  validates :name, :description, :due_date, :status, presence: true
end
