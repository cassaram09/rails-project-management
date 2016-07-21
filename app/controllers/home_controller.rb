class HomeController < ApplicationController
  layout "home_layout", except: [:profile]
  def index
  end
end
