class FlowersController < ApplicationController
  before_action :set_user, only: [:show, :index, :create]
  def set_user
    @user = User.find(params[:user_id])
  end

 # POST POST   /users/:user_id/flowers
  def create
    flower = Flower.new(flower_params)
    flower.user_id = @user.id
   #  puts(flower_params)
    if flower.save
      render json: {status: 200, message:'Flower has been created!'}
    else
      render json: {status: 422, flower: flower.errors}
    end
  end

  # GET /users/:user_id/flowers
  def index
   flowers = @user.flowers
   render json: {status: 200, flowers: flowers}
  end

  # GET GET    /users/:user_id/flowers/:id
  def show
    flower = @user.flowers.find(params[:id])
    render json: {status: 200, flower: flower}
  end

  # PATCH  /users/:user_id/flowers/:id
  def update
    flower = Flower.find(params[:id])
   if flower.update(flower_params)
     render json: flower
   else
     render json: flower.errors, status: :unprocessable_entity
   end
  end

  # DELETE /users/:user_id/flowers/:id
  def destroy
    flower = Flower.find(params[:id])
    flower.destroy
    render json: {status: 204, message:'Flower has been deleted!'}
  end

   #DELETE /users/:id
  def destroy_all
    user = User.find(params[:user_id])
    Flower.where(:user_id => user).destroy_all
    render json: {status: 204}
 end



  private
  #Only allow a trusted param "white list" through.
   def flower_params
      params.required(:flower).permit(:name, :date_planted, :perennial_or_annual, :sun, :water, :memo)
  end

end
