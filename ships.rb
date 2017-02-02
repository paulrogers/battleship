class Ship

  NS = 1
  EW =2

  attr_accessor :orientation , :bow_x , :bow_y

  def initialize
    @orientation = nil
    @bow_x = nil
    @bow_y = nil
    @hits_taken = 0
  end
  def hit
    @hits_taken+=1
  end  

  def covers?( x,y)
    if orientation == Ship::NS
      if   y >= @bow_y  and y <= ( @bow_y + length )  
        if @bow_x == x
          return true
        end
      end
    else
      if x >= @bow_x  and x <= ( @bow_x + length ) 
        if @bow_y == y
          return true
        end
      end    
    end
    return false
  end
  def sunk?
    return true if @hits_taken == length
    return false
  end
  def orientation_word
    return "NS" if self.orientation == NS
    return "EW"
  end  
    
  def length
    raise "need a concrete implementation"
  end

  def to_s
    "#{self.class.name} #{length} #{orientation_word} #{bow_y},#{bow_y}"
  end  
end

class Destroyer < Ship

  def length
  	2
  end
  def symbol
    "D"
  end  
end

class Cruiser < Ship
  
  def length
  	3
  end	
  def symbol
    "C"
  end  
  
end

class Submarine < Ship
	def length
		3
	end
  def symbol
    "S"
  end  
end		

class BattleShip < Ship
  def length
    4
  end
  def symbol
    "B"
  end    
end

class Carrier < Ship
  def length
    5
  end
  def symbol
    "X"
  end  
end    