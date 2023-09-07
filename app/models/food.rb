class Food < ApplicationRecord
  has_many :recipe_foods, dependent: :destroy, class_name: 'RecipeFood', foreign_key: 'food_id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :recipes, through: :recipe_foods

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { only_float: true, greater_than_or_equal_to: 0 }
  validates :quantity, presence: true
end
