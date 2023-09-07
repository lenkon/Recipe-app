class RecipeFood < ApplicationRecord
  belongs_to :food, class_name: 'Food', foreign_key: 'food_id'
  belongs_to :recipe, class_name: 'Recipe', foreign_key: 'recipe_id'
  has_one :user, through: :recipe

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
