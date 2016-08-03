class Project < ActiveRecord::Base
  include DateTimeConverter
  include IndexCheck
  
  has_many :notes

  has_many :tasks
  has_many :tags, through: :tasks
  has_many :comments, through: :tasks
  enum status: [:active, :complete]

  has_many :user_projects, foreign_key: "collaboration_project_id"
  has_many :collaborators, through: :user_projects
  belongs_to :owner, class_name: "User"

  scope :complete, -> { where(status: 1) }
  scope :active, -> { where(status: 0)}
  scope :overdue, -> { where("due_date < ? AND status = ?", Date.today, 0)}
  
  validates :name, :description, :due_date, :status, presence: true 

  def collaborator_emails=(emails)
    email_array = emails.split(",").map{|email| email.strip}
    email_array.each do |email|
      collaborator = User.find_by(email: email)
      if collaborator == nil || collaborator == self.owner || self.collaborators.include?(collaborator)
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

  def notes_attributes=(attributes)
    attributes.each do |k,v|
      if v["title"].blank? && v["content"].blank?
        next
      else
        self.notes.build(v)
      end
    end
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

  def tasks_complete?
    tasks.any? { |task| task.status == "active"} ? false : true
  end

  def overdue?
    self.due_date < Date.today ? true : false
  end

end
