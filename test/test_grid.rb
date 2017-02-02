require 'test/unit'
require_relative '../grid.rb'

class TestGrid < Test::Unit::TestCase

  def test_out_of_bounds
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

end	