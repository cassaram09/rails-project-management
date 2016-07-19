class NotesController < ApplicationController
  before_action :set_note, except: [:index, :new, :create]

  def index
    @notes = @user.notes.reverse
    @note = Note.new
  end

  def new

  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to notes_path
    else
      @notes = @user.notes
      @note
      render :index
    end
  end

  def show
  end

  def edit 
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
    params.require(:note).permit(:title, :content, :user_id)
  end
end
