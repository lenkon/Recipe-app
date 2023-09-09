class FoodsController < ApplicationController
  def index
    @foods = current_user.foods.order('id DESC')
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
          flash[:notice] = 'Food created successfully!'
          redirect_to foods_path
        else
          flash[:alert] = @food.errors.full_messages.first
          new_food = Food.new
          render :new, locals: { new_food: }
        end
      end
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.destroy
      flash[:notice] = 'Food deleted successfully!'
      redirect_to foods_path
    else
      flash.now[:alert] = @food.errors.full_messages.first if @food.errors.any?
      render :index, status: 400
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
