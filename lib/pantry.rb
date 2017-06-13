require 'pry'
require_relative 'recipe'

class Pantry

  attr_accessor :stock, :recipe, :shopping_list, :cook_book

  def initialize
    @stock         = {}
    @shopping_list = {}
    @cook_book     = {}
  end

  def stock_check(item)
    @stock[item] || 0
  end

  def restock(ingredient, quantity)
    if @stock[ingredient]
      @stock[ingredient] += quantity
    else
      @stock[ingredient] = quantity
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
    ingredients.map do |k,v|
      @shopping_list[k] ||= 0
      @shopping_list[k] += v
    end
  end

  def print_shopping_list
    list_output = ""
    @shopping_list.each do |ingredient, amount|
      list_output += "* #{ingredient}: #{amount}\n"
    end
    puts list_output.strip
    list_output.strip
  end

  def add_to_cookbook(recipe)
    @cook_book[recipe.name] = recipe.ingredients
  end

  def what_can_i_make
    cook_book.keys.reject do |recipe|
      stock_to_cookbook_comparison(recipe) == false
    end
  end

  def stock_to_cookbook_comparison(recipe)
    cook_book[recipe].keys.all? do |ingredient|
      stock[ingredient] >= cook_book[recipe][ingredient]
    end
  end
  
  def how_many_can_i_make
    what_can_i_make.inject({}) do |hash, item|
      #first [var]iable in the pipes ^ is the argument we pass to inject (similar to reduce i believe). Then add the total number through quantity limitation and set the key for the hash with hash[item] "aka hash[key]"
      #then that gives us our hash of how many can I make. 
      hash[item] = quantity_limitation(item).min
      hash
    end
  end

  def quantity_limitation(item)
    #changed this to map so we could get an array of the total for all ingredients and take the least amount.  Various methods that could have been used here.  I was just more comfortable with this one
    stock_limit = cook_book[item].map do |k, v|
     ((stock[k].to_f) / (v.to_f)).floor
    end
    stock_limit
  end

#   def how_many_can_i_make
#     possible_items = {}
#     what_can_i_make.each do |item|
#       possible_items[item] = quantity_limitation(item)
#     end
#     possible_items
#   end

#   def quantity_limitation(item)
#     stock_limit = 0
#     cook_book[item].each do |k, v|
#       if stock_limit = 0 || stock_limit > stock[k] / v
#         stock_limit = stock[k] / v
#       end
#     end
#     stock_limit
#   end

end
