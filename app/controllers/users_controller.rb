class UsersController < ApplicationController

  def index
    if current_user
      @friends = current_user.friends
    end
  end
  
end
