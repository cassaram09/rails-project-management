App Features
  - User can sign up and log in and log out
  - User can CRUD their own projects
  - User can CRUD their own responsibilities
  - User can CRUD their own tasks
  - User can CRUD their own comments
  - User can CRUD their own notes
  - User can CRUD their own tags, and add tags to tasks
  - User cannot CRUD other users projects/responsibilities etc
  - Admin can do everything- might need to rework this


  Later feature: add Users to projects with view / edit capabilities

  Devise for authentication
  Pundit for authorization


  Need to write tests!

  nested attribute: tag when creating a task

  Admin section / namespace?


Models
  User
  Project
  Responsibility
  Task
  TaskTag
  Tag
  Note
  Comment

  User
    has_many :projects
    has_many :responsibilities
    has_many :comments
    has_many :tasks
    has_many :notes

    t.integer :role, default: 0

    enum role: = [:user, :admin]



  Project
    belongs_to :user
    has_many :tasks
    has_many :tags, through: :tasks
    has_many :comments, through: :tasks

    enum status: = [:active, :on_hold, :complete]

    t.belongs_to :user
    t.string :name
    t.string :description
    t.date :due_date
    t.integer :status, default: 0


  Responsibility
    belongs_to :user
    has_many :comments
    has_many :tags

    enum status: = [:active, :complete]

    t.belongs_to :user
    t.string :name
    t.string :description
    t.integer :status, default: 0

  Task
    belongs_to :project
    has_many :comments
    has_many :task_tags
    has_many :tags, through: :task_tags

    enum status: = [:active, :on_hold, :complete]
    enum priority: = [:low, :medium, :high, :urgent]

    t.belongs_to :project
    t.string :name
    t.string :description
    t.date :due_date
    t.integer :status, default: 0

  Comments
    belongs_to :user
    belongs_to :task

    t.belongs_to :user
    t.belongs_to :task
    t.string :name
    t.string :description

  TaskTag
    belongs_to :task
    belongs_to :tag

    t.belongs_to :task
    t.belongs_to :tag

  Tag
    has_many :task_tags
    has_many :tasks, through: :task_tags

    t.string :name

  Note
    belongs_to :user

    t.belongs_to :user
    t.string :name
    t.string :content



