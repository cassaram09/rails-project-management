class ResponsibilitiesController < ApplicationController
  before_action :set_user, except: [:destroy]
  before_action :set_responsibility, except: [:index, :new, :create]

  def index
    @responsibilities = @user.responsibilities
    @responsibility = Responsibility.new
  end

  def new

  end

  def create
    @responsibility = Responsibility.create(responsibility_params)
    if @responsibility.save
      redirect_to responsibilities_path
    else
      @responsibilities = @user.responsibilities
      @responsibility
      render :index
    end
  end

  def show
    
  end

  def edit 
    redirect_to responsibility_path(@responsibility)
  end

  def update
    @responsibility.update(responsibility_params)
    redirect_to responsibilities_path
  end

  def destroy
    @responsibility.destroy
    redirect_to responsibilities_path
  end

  private
  def set_user
    @user = current_user
  end

  def set_responsibility
    @responsibility = Responsibility.find_by(id: params[:id])
  end

  def responsibility_params
    params.require(:responsibility).permit(:name, :description, :user_id, :status)
  end
end
