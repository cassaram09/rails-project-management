class NotesController < ApplicationController
  before_action :set_user, except: [:destroy]
  before_action :set_note, except: [:index, :new, :create]

  def index
    @notes = @user.notes
    @note = Note.new
  end

  def new

  end

  def create
    @note = Note.create(note_params)
    redirect_to notes_path
  end

  def show
  end

  def edit 
    redirect_to note_path(@note)
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
  def set_user
    @user = current_user
  end

  def set_note
    @note = Note.find_by(id: params[:id])
  end

  def note_params
    params.require(:note).permit(:name, :description, :user_id, :status)
  end
end
