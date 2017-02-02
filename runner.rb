
require_relative 'grid'

grid = Grid.new
grid.fill
grid.to_s

guess_grid = GuessGrid.new
0.upto( HEIGHT - 1 ) do |y|
  0.upto( WIDTH - 1 )do |x|
    if grid.hit?(x,y)
      puts "Hit at #{x},#{y}"
      grid.to_s
    end  
  end
end  