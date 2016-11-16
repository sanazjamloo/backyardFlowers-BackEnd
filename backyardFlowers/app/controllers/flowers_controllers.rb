class FlowersController < ApplicationController


  def set_users
   @user = User.find(params[:user_id])
 end

   # GET /flowers
  def index
   flowers = Flower.all

   render json: flowers
  end

  # GET /flowers/1
  def show
    flower = Flower.find(params[:id])
    render json: flower
  end

  # POST /flowers
   def create
     flower = Flower.new(flower_params)
    #  puts(flower_params)
     if flower.save
       render json: flower, status: :created, location: flower
     else
       render json: flower.errors, status: :unprocessable_entity
     end
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

    private
    #Only allow a trusted param "white list" through.
     def flower_params
        params.required(:flower).permit(:name, :date_planted, :perennial_or_annual, :sun, :water, :memo)
      end

    end
