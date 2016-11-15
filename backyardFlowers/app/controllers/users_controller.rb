class UsersController < ApplicationController

  def set_users
    @user = User.find(params[:id])
  end


  def create
    user = User.new(user_params)
    if user.save
      render json: {status: 200, message: "Successful Sign Up"}
    else
      render json: {status: 422, user: user.errors}
    end
  end

  def index
    users = User.all
    render json: {status: 200, users: users}
  end








































end
