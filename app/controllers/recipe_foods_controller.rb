class RecipeFoodsController < ApplicationController
  def index
    @foods = current_user.recipes_foods.select(:food_id, 'SUM(quantity) as quantity').group(:food_id, :quantity)
    @sum = 0
    @foods.each do |food|
      @sum += food.quantity * food.food.price
    end
  end

  def new
    @foods = current_user.foods
    @food_items = []
    @foods.each do |food|
      @food_items << [food.name, food.id]
    end
    @recipes = current_user.recipes
    @recipe_items = []
    @recipes.each do |recipe|
      @recipe_items << [recipe.name, recipe.id]
    end
  end

  def show; end

  def create
    @recipe_foods = RecipeFood.new(recipe_foods_params)

    respond_to do |format|
      if @recipe_foods.save
        format.html { redirect_to recipe_url(@recipe_foods.recipe), notice: 'Ingredient saved successfully.' }
        format.json { render :show, status: :created, location: @recipe_foods.recipe }
      else
        format.html { redirect_to new_recipe_foods_url, notice: 'Ingredient not saved.' }
        format.json { render json: @recipe_foods.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    RecipeFood.destroy(params[:id])
    redirect_to recipe_path(recipe_foods_params[:recipe_id])
  end

  def recipe_foods_params
    params.require(:recipe_foods).permit(:food_id, :quantity, :recipe_id)
  end
end
