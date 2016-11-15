class UsersController < ApplicationController


  def set_users
    @user = User.find(params[:id])
  end

end
