require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/emoji'

class PantryTest < Minitest::Test

  def test_class_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_if_pantry_has_empty_stock_as_hash
    pantry = Pantry.new
    expected = {}
    actual = pantry.stock

    assert_equal expected, actual
  end

  def test_for_check_items_stock
    pantry = Pantry.new
    result = pantry.stock_check("Cheese")

    assert_equal 0, result
  end

  def test_you_can_restock_pantry
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    result = pantry.stock_check("Cheese")

    assert_equal 10, result
  end

  def test_pantry_stock_accumulates
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    result_1 = pantry.stock_check("Cheese")
    expected_1 = 10

    pantry.restock("Cheese", 20)
    result_2 = pantry.stock_check("Cheese")
    expected_2 = 30

    assert_equal expected_1, result_1
    assert_equal expected_2, result_2
  end

  def test_pantry_converts_units_for_recipe
    r  = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)

    pantry = Pantry.new
    actual = pantry.convert_units(r)
    expected =
      { "Cayenne Pepper" => { quantity: 25, units: 'Milli-Units' },
        "Cheese"         => { quantity: 75, units: 'Universal Units' },
        "Flour"          => { quantity: 5, units: 'Centi-Units' }}

    assert_equal expected, actual
  end

  def test_add_recipe_to_shopping_list
    pantry = Pantry.new
    r      = Recipe.new("Cheese Pizza")

    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    expected_1 = {"Cheese" => 20, "Flour" => 20}
    actual_1   = r.ingredients

    pantry.add_to_shopping_list(r)
    expected_2 = {"Cheese" => 20, "Flour" => 20}
    actual_2   = pantry.shopping_list

    assert_equal expected_1, actual_1
    assert_equal expected_2, actual_2
  end

  def test_adding_multiple_recipes_to_shopping_list
    pantry   = Pantry.new
    r_1      = Recipe.new("Cheese Pizza")
    r_1.add_ingredient("Cheese", 20)
    r_1.add_ingredient("Flour", 20)

    r_2 = Recipe.new("Spaghetti")
    r_2.add_ingredient("Noodles", 10)
    r_2.add_ingredient("Sauce", 10)
    r_2.add_ingredient("Cheese", 5)

    pantry.add_to_shopping_list(r_1)
    pantry.add_to_shopping_list(r_2)

    expected = {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}
    actual  = pantry.shopping_list

    assert_equal expected, actual
  end

  def test_shopping_list_can_be_printed
    pantry   = Pantry.new
    r_1      = Recipe.new("Cheese Pizza")
    r_1.add_ingredient("Cheese", 20)
    r_1.add_ingredient("Flour", 20)

    r_2 = Recipe.new("Spaghetti")
    r_2.add_ingredient("Noodles", 10)
    r_2.add_ingredient("Marinara Sauce", 10)
    r_2.add_ingredient("Cheese", 5)

    pantry.add_to_shopping_list(r_1)
    pantry.add_to_shopping_list(r_2)

    expected = "* Cheese: 25\n* Flour: 20\n* Noodles: 10\n* Marinara Sauce: 10"
    actual = pantry.print_shopping_list

    assert_equal expected, actual
  end

  def test_it_can_add_to_cookbook
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    assert_equal Hash, pantry.cook_book.class
    assert_equal 3, pantry.cook_book.length
  end

  def test_it_can_show_what_to_make
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    expected = ["Pickles", "Peanuts"]
    actual = pantry.what_can_i_make

    assert_equal expected, actual
  end

  def test_it_tells_you_how_much_you_can_make
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    expected = {"Pickles" => 1, "Peanuts" => 2}
    actual = pantry.how_many_can_i_make

    assert_equal expected, actual
  end

end
