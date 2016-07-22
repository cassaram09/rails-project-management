class Task < ActiveRecord::Base
  include DateTimeConverter
  extend KeywordSearch
  
  belongs_to :project
  belongs_to :user
  has_many :comments
  has_many :task_tags
  has_many :tags, through: :task_tags

  enum status: [:active, :complete]
  enum priority: [:low, :medium, :high, :urgent]

  validates :name, :description, :due_date, :status, :priority, :project_id, presence: true

  scope :complete, -> { where(status: 1) }
  scope :active, -> { where(status: 0)}
  scope :overdue, -> { where("due_date < ?", Date.today)}

  scope :search, -> (search, user) { where("(name LIKE ? OR description LIKE ?) AND user_id = ?", "%#{search}%", "%#{search}%", user.id)}

  #custom writer and readers for Task for creating nested attributes

  def tag_names=(tags)
    tag_array = tags.split(",").map{|tag| tag.strip}
    tag_array.each do |tag|
      new_tag = Tag.find_or_create_by(name: tag)
      self.tags << new_tag
      self.user.tags << new_tag
    end
  end

  def tag_names
    tags = self.tags.collect {|tag| tag.name}
    tags.join(", ")
  end

  def self.search_by_tags(tags, current_user_id)
    tag_array = tags.split(" ").map{|tag| tag.strip}
    tasks = tag_array.collect do |tag|
      tag_object = Tag.find_by(name: tag, user_id: current_user_id)
      tag_object.try(:tasks)
    end
    tasks.flatten.uniq.compact
  end



end

# When a user inputs a list of tags, the form should return all tasks that have that tag. 