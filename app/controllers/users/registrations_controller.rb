class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def edit
    if current_user.admin?
      if params[:format]
        @user = User.find_by(id: params[:format].to_i)
      else
       @user = current_user
      end
    end
    render :edit
  end

  protected
  # Overwrite update_resource to let users to update their user without giving their password
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end
