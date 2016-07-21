class Project < ActiveRecord::Base
  include DateTimeConverter
  
  belongs_to :user
  has_many :tasks
  has_many :tags, through: :tasks
  has_many :comments, through: :tasks
  enum status: [:active, :on_hold, :complete]

  scope :complete, -> { where(status: 2) }
  scope :on_hold, -> { where(status: 1) }
  scope :active, -> { where(status: 0)}

  validates :name, :description, :due_date, :status, presence: true

  def self.search(search)
    where("name LIKE ? OR description LIKE ? ", "%#{search}%", "%#{search}%") 
  end

  def active_tasks
    self.tasks.active 
  end

  def complete_tasks
    self.tasks.complete
  end

  def on_hold_tasks
    self.tasks.on_hold
  end
end
