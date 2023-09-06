class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    new_food = Food.new
    respond_to do |format|
      format.html { render :new, locals: { new_food: } }
    end
  end

  def create
    @food = current_user.foods.new(food_params)
    respond_to do |format|
      format.html do
        if @food.save
          redirect_to foods_path
        else
          new_food = Food.new
          render :new, locals: { new_food: }
        end
      end
    end
  end

  def destroy
    Food.destroy(params[:id])
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
