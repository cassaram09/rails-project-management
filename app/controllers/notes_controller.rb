class NotesController < ApplicationController
  layout "notes_layout"
  before_action :set_project, except: [:show, :edit]
  before_action :set_note, except: [:index, :new, :create]

  def index
    @notes = @project.notes.reverse
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to note_path(@note)
    else
      render :index
    end
  end

  def show
    @project = @note.project
  end

  def edit 
    @project = @note.project
  end

  def update
    @note.update(note_params)
    redirect_to notes_path
  end

  def destroy
    @note.destroy
    redirect_to notes_path
  end

  private
  def set_note
    @note = Note.find_by(id: params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, :user_id, :project_id)
  end

  def set_project
    if params[:id]
       @project = Project.find_by(id: params[:id])
    else
      @project = Project.find_by(id: params[:project_id])
    end
  end

end
