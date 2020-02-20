class User::BaseController < ApplicationController
  before_action :require_user
  
  def require_user
    render file: "/public/404" unless regular_user?
  end
  
end