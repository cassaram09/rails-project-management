class Users::RegistrationsController < Devise::RegistrationsController
  protected
  # Overwrite update_resource to let users to update their user without giving their password
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end
