require 'pry'
require_relative 'recipe'

class Pantry

  # attr_reader   :recipe
  attr_accessor :stock, :recipe, :shopping_list

  def initialize
    @stock      = {}
    @recipe     = Recipe.new(recipe)
    @shopping_list = {}
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
    ingredients = recipe.ingredients
    converted_units = {}
    ingredients.each do |k,v|
      if v < 1
        converted_units[k] = {quantity: (v * 1000), units: "Milli-Units"}
      elsif v > 100
        converted_units[k] = {quantity: (v / 100), units: "Centi-Units"}
      else
        converted_units[k] = {quantity: v, units: "Universal Units"}
      end
    end
    converted_units
  end

  def add_to_shopping_list(recipe)
    ingredients = recipe.ingredients
    @shopping_list = ingredients.each do |k,v|
      shopping_list[k] ||= 0
      shopping_list[k] += v
    end 
  end



  # def convert_units(recipe)
  #   recipe.ingredients.map do |item, quantity|
  #     recipe.ingredients[item] = if quantity < 1
  #                                 milli_units(quantity)
  #                               elsif quantity > 100
  #                                 centi_units(quantity)
  #                               else
  #                                 universal_units(quantity)
  #                               end
  #   end
  #   recipe.ingredients
  # end
  #
  # def milli_units(quantity)
  #   { quantity: (quantity * 1000).round, units: "Milli-units"}
  # end
  #
  # def centi_units(quantity)
  #   { quantity: (quantity / 100), units: "Centi-Units"}
  # end
  #
  # def universal_units(quantity)
  #   { quantity: quantity, units: "Universal Units" }
  # end


end





# ] pry(main)> dogs = {mutt: "brown", golden: "yellow", lab: "yellow"}
# => {:mutt=>"brown", :golden=>"yellow", :lab=>"yellow"}
# [41] pry(main)> dogs.keys.each do |dog|
# [41] pry(main)*   dogs[dog] = "black" if dogs[dog] == "yellow"
# [41] pry(main)*   dogs[dog] = "white" if dogs[dog] == "brown"
# [41] pry(main)*   dogs[dog] = "yellow or black" if dog.to_s == "lab"
# [41] pry(main)* end
# => [:mutt, :golden, :lab]
# [42] pry(main)> dogs
# => {:mutt=>"white", :golden=>"black", :lab=>"yellow or black"}
#
#
# ings = { a: [5, "liters"], b: [20, "liters"]}
# => {:a=>[5, "liters"], :b=>[20, "liters"]}
# [51] pry(main)> ings.keys.each do |key|
# [51] pry(main)*   ings[key] = [ings[key][0]/10, "decaliters"] if ings[key][0] >= 10
# [51] pry(main)* end
# => [:a, :b]
# [52] pry(main)> ings
# => {:a=>[5, "liters"], :b=>[2, "decaliters"]}
