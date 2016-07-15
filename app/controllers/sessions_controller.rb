class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by(:uid => auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
    end
    session[:user_id] = user.id
  end
 
  def auth
    request.env['omniauth.auth']
  end
end
