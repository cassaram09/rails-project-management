class Project < ActiveRecord::Base
  include DateTimeConverter
  extend KeywordSearch
  
  has_many :tasks
  has_many :tags, through: :tasks
  has_many :comments, through: :tasks
  enum status: [:active, :complete]

  has_many :user_projects, foreign_key: "collaboration_project_id"
  has_many :collaborators, through: :user_projects
  belongs_to :owner, class_name: "User"

  scope :complete, -> { where(status: 1) }
  scope :active, -> { where(status: 0)}
  scope :overdue, -> { where("due_date < ?", Date.today)}
  scope :search, -> (search, user) { where("(name LIKE ? OR description LIKE ?) AND owner_id = ?", "%#{search}%", "%#{search}%", user.id)}



  validates :name, :description, :due_date, :status, presence: true 
  def collaborator_emails=(emails)
    self.collaborators.clear
    email_array = emails.split(",").map{|email| email.strip}
    email_array.each do |email|
      collaborator = User.find_by(email: email)
      if collaborator == nil || collaborator == self.owner
        next
      end
      self.collaborators << collaborator
      self.save
    end
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

  def overdue_tasks
    self.tasks.overdue
  end

end
