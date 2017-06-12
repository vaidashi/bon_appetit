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

    pantry.add_to_shopping_list(r)
    expected = {"Cheese" => 20, "Flour" => 20}
    actual = pantry.shopping_list

    assert_equal expected, actual
  end

  def test_adding_multiple_recipes_to_shopping_list
    pantry = Pantry.new
    r      = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    r_2 = Recipe.new("Spaghetti")
    r_2.add_ingredient("Noodles", 10)
    r_2.add_ingredient("Sauce", 10)
    r_2.add_ingredient("Cheese", 5)

    pantry.add_to_shopping_list(r)
    pantry.add_to_shopping_list(r_2)

    expected = {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}
    actual  = pantry.shopping_list

    assert_equal expected, actual
  end

  def test_shopping_list_can_be_printed
    pantry = Pantry.new
    r      = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    r_2 = Recipe.new("Spaghetti")
    r_2.add_ingredient("Noodles", 10)
    r_2.add_ingredient("Marinara Sauce", 10)
    r_2.add_ingredient("Cheese", 5)

    pantry.add_to_shopping_list(r)
    pantry.add_to_shopping_list(r_2)

    expected = "* Cheese: 25\n* Flour: 20\n* Noodles: 10\n* Marinara Sauce: 10"
    actual = pantry.print_shopping_list

    assert_equal expected, actual
  end

end
