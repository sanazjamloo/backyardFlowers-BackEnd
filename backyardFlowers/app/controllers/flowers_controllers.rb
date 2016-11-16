class FlowersController < ApplicationController


  def set_users
   @user = User.find(params[:user_id])
 end

 # POST /flowers
  def create
    flower = Flower.new(flower_params)
    flower.user_id = @user.id
   #  puts(flower_params)
    if flower.save
      render json: {status: 200, message:'Created a new flower!'}
    else
      render json: {status: 422, flower: flower.errors}
    end
  end

     # GET /flowers
    def index
     flowers = @user.flower
     render json: {status: 200, flowers: flowers}
    end

    # GET /flowers/1
      def show
        flower = @user.flower.find(params[:id])
        render json: {status: 200, flower: flower}
      end

    # PATCH/PUT /flowers/1
    def update
     flower = Flower.find(params[:id])
     if flower.update(flower_params)
       render json: flower
     else
       render json: flower.errors, status: :unprocessable_entity
     end
    end

    # DELETE /flowers/1
    def destroy
      flower = Flower.find(params[:id])
      flower.destroy
      render json: {status: 204}
    end

      def destroy_all
    @user = User.find(params[:user_id])
    Flower.where(:user_id => @user).destroy_all
    render json: {status: 204}
   end

    private
    #Only allow a trusted param "white list" through.
     def flower_params
        params.required(:flower).permit(:name, :date_planted, :perennial_or_annual, :sun, :water, :memo)
    end

end
