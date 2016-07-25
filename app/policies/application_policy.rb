class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private
  def find_user_project
    if record.class.name == "Project"
      UserProject.find_by(collaborator_id: user.id, collaboration_project_id: record.id )
    else
      UserProject.find_by(collaborator_id: user.id, collaboration_project_id: record.project.id )
    end
  end

  def project_owner?
    record.project.owner == user 
  end

  def task_owner?
    record.task.owner == user
  end

  def record_owner?
    if record.class.name == "Project" || record.class.name == "Task"
      record.owner == user
    else
      record.user == user
    end
  end

  def comment_project_owner?
    record.task.project.owner == user 
  end
end
