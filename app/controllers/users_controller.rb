class UsersController < ApplicationController
  def index
    @users = User.get_active
  end

end
