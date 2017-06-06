


class Pantry

  attr_accessor :stock

  def initialize
    @stock = {}

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

end


# counted_animals = {}
# animals.each do |animal|
#   if counted_animals[animal]
#     counted_animals[animal] += 1
#   else
#     counted_animals[animal] = 1
#   end
# end
