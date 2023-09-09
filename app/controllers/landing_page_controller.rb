class LandingPageController < ApplicationController
  def index
    @recipes = Recipe.includes(:recipe_foods).where(public: 't').order('id DESC')
  end
end
