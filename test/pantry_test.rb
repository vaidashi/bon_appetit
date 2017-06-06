require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/emoji'

class PantryTest < Minitest::Test

  def test_class_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_it_pantry_has_stock_as_hash
    pantry = Pantry.new

    assert_equal Hash, pantry.stock.class
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
    pantry.restock("Cheese", 20)

    result = pantry.stock_check("Cheese")

    assert_equal 30, result
  end


end
