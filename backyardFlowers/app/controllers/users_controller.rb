class UsersController < ApplicationController
  before_action :authenticate, except: [:login, :create]

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

  def show
   user = User.find(params[:id])
   render json: {status: 200, user: user}
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: {status: 204}
  end

   def login
     user = User.find_by(username: params[:user][:username])
     if user && user.authenticate(params[:user][:password])
        token  = token(user.id, user.username)
       render json: {status: 201, token: token, user: user}
     else
       render json: {status: 401, message: "Unauthorized"}
     end
   end




  private
  #strong params
    def token(id, username)
      JWT.encode(payload(id, username), ENV['JWT_SECRET'], 'HS256')
    end

    def payload(id, username)
      {
        exp: (Time.now + 1.day).to_i, #expires 24 hours from now
        iat: Time.now.to_i,
        iss: ENV['JWT_ISSUER'],
        user: {
          id: id,
          username: username
        }
      }
end


  private
  #Only allow a trusted parameter "white list" through.
    def user_params
      params.required(:user).permit(:username, :password, :email_address)
    end

    def pass_params
    params.required(:update).permit(:password, :email_address)
  end

end
