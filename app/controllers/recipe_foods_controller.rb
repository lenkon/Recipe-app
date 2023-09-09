class RecipeFoodsController < ApplicationController
  def index
    @foods = current_user.recipe_foods.select(:food_id, 'SUM(quantity) as quantity').group(:food_id, :quantity)
    @sum = 0
    @foods.each do |food|
      @sum += food.quantity * food.food.price
    end
  end

  def create
    @recipes_foods = RecipeFood.where('food_id = :x and recipe_id = :y',
                                      x: recipes_foods_params[:food_id], y: recipes_foods_params[:recipe_id])

    if @recipes_foods.empty?
      @recipes_foods = RecipeFood.new(recipes_foods_params)
    else
      @recipes_foods.update(recipes_foods_params)
      redirect_to recipe_url(@recipes_foods[0].recipe) and return
    end

    respond_to do |format|
      if @recipes_foods.save
        format.html { redirect_to recipe_url(@recipes_foods.recipe), notice: 'Ingredient was successfully saved.' }
        format.json { render :show, status: :created, location: @recipes_foods.recipe }
      else
        format.html { redirect_to new_recipe_recipes_food_url, notice: 'Ingredient was not successfully saved.' }
        format.json { render json: @recipes_foods.errors, status: :unprocessable_entity }
      end
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

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipes_foods_params)
      flash[:succes] = 'Recipe food successfully updated'
      redirect_to recipe_path(@recipe_food.recipe)
    else
      flash[:error] = 'Recipe food update failed'
      render :edit
    end
  end

  def destroy
    unless @recipe_food.recipe.user == current_user
      flash[:alert] = 'You cannot remove the ingredient that belongs to other Users.'
      return redirect_to recipe_path(@recipe)
    end

    if @recipe_food.destroy
      flash[:notice] = 'Ingredient was successfully removed.'
    elsif @recipe_food.errors.any?
      flash[:alert] = @recipe_food.errors.full_messages.first
    end
    redirect_to recipe_path(@recipe)
  end

  def recipes_foods_params
    params.require(:recipe_food).permit(:food_id, :quantity, :recipe_id)
  end
end
