require 'pry'
require_relative 'recipe'

class Pantry

  # attr_reader   :recipe
  attr_accessor :stock, :recipe

  def initialize
    @stock      = {}
    @recipe     = Recipe.new(recipe)
  end

  def stock_check(item)
    @stock[item] || 0
  end

  def restock(ingredient, quantity)
    if @stock[ingredient]
      @stock[ingredient] += quantity
    else
      @stock = {ingredient => quantity}
    end
  end

  def convert_units(recipe)
    @recipe.ingredients.map do |key, value|
      if value > 100
         value / 100
      elsif value < 1
         value * 1000
      else
         value * 1
      end
    end
  end




# binding.pry
end
