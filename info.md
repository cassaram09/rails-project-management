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

  fix flash alert on log in and sign up pages

  Projects are temporary endeavors to create something and have defined start and finish points.

  Responsibilities are recurring tasks that need to be completed.
    - user should be able to check off a box indicating they have completed the task for that day
    - checkboxes should automatically update the date every day
    - clicking on a responsibility should show the statistics for that, frequency, streaks, days completed, etc.

  SocialMedia
   t.string :name
   t.string :url


  UserProjects
  - how to add other users to people's projects

  UserProjects
    user_id
    project_id
    permission - read, write, manage 

  Two types of Users:

   owners: Own a project / created it
    has_many :projects , a project belongs to an owner

   collaborators: invited to collaborate on a project 
    has_many :collaboration_projects, class: "Project"
    a collaborator can have many projects and a project can have many collaborators

    CollaborateProjects
      t.belongs_to :collaborator class: "User"
      t.belongs_to :collaboration_project, class: "Project"
      t.integer :permission   

      permission enum :permission [:view, :edit]

    Users
      has_many :collaboration_projects, foreign_key: "collaborator_id"
      has_many :projects, foreign_key: "owner_id"
      has_many :invited_projects, through: :collaboration_projects

    Projects
      has_many :collaboration_projects, foreign_key: "collaboration_project_id"
      has_many :collaborators, through: :collaboration_projects
      belongs_to :owner, class_name: "User"







  Notes are general musings.

  Comments are on tasks during a project. 

  Tags are used to help label and sort projects. 

  Add custom validator for Tasks - unique names in projects

  Users
    - add full name

  OMNIAUTH!

  Add other users to other project

  add search

  Tasks
   - add task when creating project
   - quick add task from tasks page 

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



USer Feedback Notes
 add project show page, have user redirected there after project creation


 adjust headers


 Active Projects and Complete Projects. Each Project Card should list if its owner or collaborator


 nest comments and notes under projects
