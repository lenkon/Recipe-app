class RecipeFoodsController < ApplicationController
    def create
      @recipe_foods = RecipeFood.new(recipe_foods_params)
  
      respond_to do |format|
        if @recipe_foods.save
          format.html { redirect_to recipe_url(@recipe_foods.recipe), notice: 'Ingredient saved successfully.' }
          format.json { render :show, status: :created, location: @recipe_foods.recipe }
        else
          format.html { redirect_to recipe_url(recipe_foods_params[:recipe_id]), notice: 'Ingredient not saved.' }
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