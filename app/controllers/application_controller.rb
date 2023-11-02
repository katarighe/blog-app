class ApplicationController < ActionController::Base
  def current_user
    @first.user = User.first
  end
end
