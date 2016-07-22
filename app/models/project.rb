class Project < ActiveRecord::Base
  include DateTimeConverter
  extend KeywordSearch
  
  #belongs_to :user
  has_many :tasks
  has_many :tags, through: :tasks
  has_many :comments, through: :tasks
  enum status: [:active, :on_hold, :complete]

  has_many :user_projects, foreign_key: "collaboration_project_id"
  has_many :collaborators, through: :user_projects
  belongs_to :owner, class_name: "User"


  scope :complete, -> { where(status: 2) }
  scope :on_hold, -> { where(status: 1) }
  scope :active, -> { where(status: 0)}
  scope :search, -> (search, user) { where("(name LIKE ? OR description LIKE ?) AND user_id = ?", "%#{search}%", "%#{search}%", user.id)}

  validates :name, :description, :due_date, :status, presence: true 
  def collaborator_emails=(emails)
    binding.pry
    email_array = emails.split(",").map{|email| email.strip}
    email_array.each do |email|
      collaborator = User.find_by(email: email)
      self.collaborators << collaborator
      self.save
    end
    binding.pry
  end

  def collaborator_emails
    emails = self.collaborators.collect {|collaborator| collaborator.email}
    emails.join(", ")
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
