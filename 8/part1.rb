input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

class Grid
	attr_accessor :map
	def initialize(data)
		@map = data.map{|x| x.split(//)}
	end

	def visible?(y, x)
		current = @map[y][x]

				
		test_visible(y,x)
	end

	def test_visible(y, x)
		radius = 1
		current = @map[y][x]

		cases = nil

		while (@map[y-radius] || @map[y+radius] || @map[y][x-radius] || @map[y][x+radius]) do
				cases ||= [
					Proc.new { |r| y-r >= 0 && @map[y-r][x] },
					Proc.new { |r| y+r < @map.size && @map[y+r][x] },
					Proc.new { |r| x-r >= 0 && @map[y][x-r]  },
					Proc.new { |r| x+r < @map[y].size && @map[y][x+r] },
				]

			if cases.any? { |x| ! x.call(radius)}
				return true
			elsif cases.any? {|x| x.call(radius) < current}
				cases = cases.filter {|x| x.call(radius) && x.call(radius) < current}
				radius += 1
			else
				return false
			end
		end

		true
	end
end

grid = Grid.new(file_data)

y = 0;
x = 0;

visible_trees = 0

while grid.map[y]
	while grid.map[y][x]
		
		visible_trees += 1 if grid.visible?(y, x)
		
		x += 1
	end
	y += 1
	x = 0
end

p visible_trees