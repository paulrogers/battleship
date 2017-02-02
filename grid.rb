require_relative "ships"

  EMPTY_CHAR = "-"

  WIDTH = 10
  HEIGHT = 10

class Grid


  def initialize
    @ships = []
    @shots_receeived = 0
    @grid = []
    HEIGHT.times do |y|
      @grid[y] = []
      WIDTH.times do |x| 
      	@grid[y][x] = EMPTY_CHAR 
      end	
    end  
  end	

  def out_of_bounds?( ship )
    if ship.orientation == Ship::NS

      if ship.bow_y + ship.length > HEIGHT
        puts "ship #{ship.to_s} would go beyond boundary NS"
        return true
      end	
    else  # EW
      if ship.bow_x + ship.length > WIDTH
        puts "ship #{ship.to_s} would go beyond boundary EW"
        return true
      end	
    end	
    return false
  end	

  def update_grid_with( ship )
    x = ship.bow_x
    y = ship.bow_y
    if ship.orientation == Ship::NS
      puts "NS start at #{x},#{y } end at #{x},#{y + ship.length}"
      y.upto( y + ship.length - 1) do |dy|
        puts "NS update_grid_with #{x}, #{dy} = #{ship.symbol}"
        @grid[x][dy] = ship.symbol
      end  
    else
      puts "EW start at #{x },#{y} end at #{x + ship.length},#{y}"
      x.upto( x + ship.length - 1 ) do |dx|
        puts "EW update_grid_with #{dx}, #{y} = #{ship.symbol}"
        @grid[dx][y] = ship.symbol
      end  
    end	
  end	

  def grid(x,y)
    return@grid[x][y]
  end  


  def touching_other_ships?( ship )
    x = ship.bow_x
    y = ship.bow_y
    if ship.orientation == Ship::NS
     
      puts "NS touch check start at #{x},#{y } end at #{x},#{y + ship.length}"
      y.upto( y + ship.length - 1) do |dy|
        puts "NS touch check at  #{x}, #{dy} = #{ship.symbol}"
        if @grid[x][dy] != EMPTY_CHAR
          return true
        end  
      end  
    else
      puts "EW touch check start at #{x },#{y} end at #{x + ship.length},#{y}"
      x.upto( x + ship.length - 1 ) do |dx|
        puts "EW touch check at #{dx}, #{y} "
        if @grid[dx][y] != EMPTY_CHAR
          return true
        end  
      end  
    end 
    return false
  end  

  def is_placement_valid?( ship )
    if out_of_bounds?( ship )
      return false
    end
    if touching_other_ships?( ship )
      return false
    end
    return true
  end

  def place( ship)
    tt = rand(100)
    if tt < 50
      ship.orientation =  Ship::NS
    else
      ship.orientation = Ship::EW
    end      
    
    puts "Orientation is #{ ship.orientation_word }"
    ship.bow_x = rand( WIDTH )
    ship.bow_y = rand( HEIGHT )
    puts ship.to_s
    return ship
  end	

  def add_ship_to_game( ship )
    @ships << ship
  end  

  def fill

    
    add_ship_to_game Carrier.new
    add_ship_to_game Submarine.new
    add_ship_to_game Cruiser.new
    add_ship_to_game Destroyer.new

    @ships.each do | ship |

      ship = place( ship )	
      while !is_placement_valid?( ship )
        # need to replace this ship, its either out of bounds, or touching another  
        ship = place( ship )  
      end   
      update_grid_with( ship )
      

    end	

  end

  def all_ships_sunk?
    @ships.each do |ship|
      return false if !ship.sunk?
    end  
    return true
  end  

  def ship_at( x,y )
   this_ship = nil
   @ships.each do |ship|
    if ship.covers?( x,y )
      this_ship = ship
      break
    end
   end   
   raise "Failed to find what ship is at #{x},#{y}" if this_ship.nil?
   return this_ship
  end  

  def hit?( x,y )
    @shots_receeived +=1
    return false if @grid[x][y] == EMPTY_CHAR
    @grid[x][y] = @grid[x][y].downcase
    # need to update the ship at this location, that its been hit
    ship = ship_at( x,y )
    ship.hit
    if ship.sunk?
      puts "#{ship.class.name} has been sunk!"
      if all_ships_sunk?
        puts "All ships sunk in #{@shots_receeived} shots. Game Over"
        exit
      end  
    end  
    return true
  end  

  def to_s

    (HEIGHT - 1).downto( 0 ) do |y|
      print "#{y} "
      0.upto( WIDTH - 1 ) do |x|
        
        print @grid[x][y].to_s + " "
      end
      print "\n"
    end
    print "  "    
    0.upto( WIDTH - 1 ) do |x|
      print "#{x} "
    end 
    print "\n" 
  end	

end

class GuessGrid
 def initialize
    @grid = []
    HEIGHT.times do |y|
      @grid[y] = []
      WIDTH.times do |x| 
        @grid[y][x] = EMPTY_CHAR 
      end 
    end  
    
  end 
end  

