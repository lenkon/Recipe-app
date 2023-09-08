class RecipeFoodsController < ApplicationController
  def index
    @foods = current_user.recipe_foods.select(:food_id, 'SUM(quantity) as quantity').group(:food_id, :quantity)
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
    @recipe = current_user.recipes.find(params[:recipe_id])
  end

  def show; end

  def create
    @recipe_foods = RecipeFood.where('food_id = :x and recipe_id = :y',
                                     x: recipe_foods_params[:food_id], y: recipe_foods_params[:recipe_id])

    if @recipe_foods.empty?
      @recipe_foods = RecipeFood.new(recipe_foods_params)
    else
      @recipe_foods.update(recipe_foods_params)
      redirect_to recipe_url(@recipe_foods[0].recipe) and return
    end

    respond_to do |format|
      if @recipe_foods.save
        format.html { redirect_to recipe_url(@recipe_foods.recipe), notice: 'Ingredient saved successfully.' }
        format.json { render :show, status: :created, location: @recipe_foods.recipe }
      else
        format.html { redirect_to new_recipe_recipe_food_url, notice: 'Ingredient not saved.' }
        format.json { render json: @recipe_foods.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_foods_params)
      flash[:succes] = 'Recipe food updated successfully'
      redirect_to recipe_path(@recipe_food.recipe)
    else
      flash[:error] = 'Recipe food update failed'
      render :edit
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
