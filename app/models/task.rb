class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :comments
  has_many :task_tags
  has_many :tags, through: :task_tags

  enum status: [:active, :on_hold, :complete]
  enum priority: [:low, :medium, :high, :urgent]

  scope :complete, -> { where(status: 2) }
  scope :on_hold, -> { where(status: 1) }
  scope :active, -> { where(status: 0)}

  #custom writer and readers for Task for creating nested attributes

  def tag_names=(tags)
    tag_array = tags.split(",").map{|tag| tag.strip}
    tag_array.each do |tag|
      new_tag = Tag.find_or_create_by(name: tag)
      self.tags << new_tag
    end
  end

  def tag_names
    tags = self.tags.collect {|tag| tag.name}
    tags.join(", ")
  end



end
