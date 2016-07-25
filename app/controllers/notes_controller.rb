class NotesController < ApplicationController
  layout "notes_layout"
  before_action :set_project, except: [:show, :edit]
  before_action :set_note, except: [:index, :new, :create]

   ## STANDARD RESTFUL ROUTES

  def index
    if @project.owner == @user || @user.admin? || @project.collaborators.include?(@user)
      @notes = @project.notes.reverse
    else
      flash[:alert] = "You are not authorized to perform that action."
      redirect_to root_path
    end
  end

  def new
    @note = Note.new(project_id: @project.id)
    authorize @note
  end

  def create
    @note = Note.new(note_params)
    authorize @note
    if @note.save
      redirect_to note_path(@note)
    else
      render :new
    end
  end

  def show
    @project = @note.project
    authorize @note
  end

  def edit 
    @project = @note.project
    authorize @note
  end

  def update
    authorize @note
    @note.update(note_params)
    redirect_to note_path(@note)
  end

  def destroy
    authorize @note
    @note.destroy
    redirect_to project_notes_path(@project)
  end

  ## PRIVATE METHODS

  private
  def set_note
    @note = Note.find_by(id: params[:id])
  end

   def set_project
    if params[:id]
       @project = Project.find_by(id: params[:id])
    else
      @project = Project.find_by(id: params[:project_id])
    end
  end

  def note_params
    params.require(:note).permit(:title, :content, :user_id, :project_id)
  end
end
