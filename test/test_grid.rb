require 'test/unit'
require_relative '../grid.rb'

class TestGrid < Test::Unit::TestCase

  def test_adding_a_ship_to_grid
  	grid = Grid.new
    assert( grid.grid( 1,1) == Grid::EMPTY_CHAR )

    ship = Carrier.new
    ship.orientation = Ship::EW
    ship.bow_x = 1
    ship.bow_y = 1
    grid.update_grid_with( ship )
    assert( grid.grid( 1,1) == ship.symbol )
  end	


  def test_out_of_bounds_east_west
    grid = Grid.new
    ship = Carrier.new
    ship.orientation = Ship::EW
    ship.bow_x = 9
    ship.bow_y = 9
    assert( grid.out_of_bounds?( ship ))

    ship.bow_x = 0
    ship.bow_y = 0
    assert( false == grid.out_of_bounds?( ship ))


  end	
  
  def test_out_of_bounds_north_south
    grid = Grid.new
    ship = Carrier.new
    ship.orientation = Ship::NS
    ship.bow_x = 9
    ship.bow_y = 9
    assert( grid.out_of_bounds?( ship ))

    ship.bow_x = 0
    ship.bow_y = 0
    assert( false == grid.out_of_bounds?( ship ))


  end	
  def test_touching_other_ships_not_touching
    grid = Grid.new
    initial_ship = Carrier.new
    initial_ship.bow_x = 1
    initial_ship.bow_y = 1
    initial_ship.orientation = Ship::NS
    grid.update_grid_with( initial_ship )
    ship = Carrier.new
    ship.bow_x = 0
    ship.bow_y = 0
    ship.orientation = Ship::NS
    assert( false == grid.touching_other_ships?( ship ) )
  end
  def test_touching_other_ships_touching
    grid = Grid.new
    initial_ship = Carrier.new
    initial_ship.bow_x = 1
    initial_ship.bow_y = 1
    initial_ship.orientation = Ship::NS
    grid.update_grid_with( initial_ship )
    ship = Carrier.new
    ship.bow_x = 1
    ship.bow_y = 1
    ship.orientation = Ship::NS
    assert( grid.touching_other_ships?( ship ) )
  end
end	