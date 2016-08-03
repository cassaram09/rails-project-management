class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :projects
  has_many :comments
  has_many :notes
  has_many :tags 

  has_many :user_projects, foreign_key: "collaborator_id"
  has_many :projects, foreign_key: "owner_id"
  has_many :collaboration_projects, through: :user_projects

  has_many :assigned_tasks, through: :user_tasks
  has_many :user_tasks, foreign_key: "assigned_user_id"
  has_many :tasks, foreign_key: "owner_id"
  
  enum role: [:user, :admin]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end    
  end

  def all_active_projects
    self.projects.active + self.collaboration_projects
  end

  def active_projects
    self.projects.active 
  end

  def complete_projects
    self.projects.complete
  end

  def overdue_projects
    self.projects.overdue
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

  def active_assigned_tasks
    self.assigned_tasks.active 
  end

  def complete_assigned_tasks
    self.assigned_tasks.complete
  end

  def overdue_assigned_tasks
    self.assigned_tasks.overdue
  end

  def collaboration_tags
    self.collaboration_projects.collect {|task| task.tags.collect {|tag| tag}}
  end

end
