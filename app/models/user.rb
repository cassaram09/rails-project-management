class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :projects #foreing_key user_id
  has_many :responsibilities
  has_many :comments
  has_many :tasks
  has_many :notes
  has_many :tags 

  has_many :user_projects
  

  enum role: [:user, :admin]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end    
  end

  #collect all tags from all tasks owned by the user
  # def tags
  #   tags = self.tasks.collect do |task|
  #     task.tags.collect {|tag| tag}
  #   end.flatten
  # end

  def active_projects
    self.projects.active 
  end

  def complete_projects
    self.projects.complete
  end

  def on_hold_projects
    self.projects.on_hold
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

  # Tasks are nested under projects, so we need a custom method to find all of a user's tasks
  # def all_user_tasks
  #   self.projects.map do |project|
  #     project.tasks
  #   end.flatten
  # end

  # def all_tasks_query
  #   Task.where(project_id: self.project_ids).where("user_id = ?", self.id)
  # end
end
