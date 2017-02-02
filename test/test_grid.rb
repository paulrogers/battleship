require 'test/unit'
require_relative '../grid.rb'

class TestGrid < Test::Unit::TestCase

  def test_adding_a_ship_to_grid
  	x = y =1
  	grid = Grid.new
    assert( grid.grid( x,y) == Grid::EMPTY_CHAR )

    ship = Carrier.new
    ship.orientation = Ship::EW
    ship.bow_x = x
    ship.bow_y = y
    grid.update_grid_with( ship )
    assert( grid.grid( x,y) == ship.symbol )
    assert( grid.grid( x + ship.length - 1 ,y) == ship.symbol )
    assert( grid.grid( x + ship.length  ,y) == Grid::EMPTY_CHAR )
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

  def test_ship_at
    grid = Grid.new
    assert_raises{ grid.ship_at( 1, 1 )}
    initial_ship = Carrier.new
    initial_ship.bow_x = 1
    initial_ship.bow_y = 1
    initial_ship.orientation = Ship::NS
    grid.add_ship_to_game initial_ship
    grid.update_grid_with( initial_ship )
    ship_from_grid = nil
    assert_nothing_raised{ ship_from_grid =  grid.ship_at( 1, 1 )}
    assert_not_nil(ship_from_grid )
    assert( ship_from_grid == initial_ship )
  end	

end	