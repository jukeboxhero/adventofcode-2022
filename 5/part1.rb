input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

delimeter = file_data.find_index("")
input_part_1 = file_data[0...delimeter]
input_part_2 = file_data[(delimeter+1)..-1]

class CargoGrid 
	require 'matrix'

	attr_accessor :stacks

	def initialize(input)
		input.reverse!
		first = input.shift

		@stacks = StackCollection.new(first.split(' '))

		input.each do |lines| 
			lines.gsub('    ', ' [] ').split(' ').each_with_index do |x, i| 
				entry = x.gsub(/\[|\]/, "")
				next if entry === ""
				@stacks.find(i + 1).add(entry)
			end
		end
	end

	def render
		height = @stacks.height
		output = Array.new(@stacks.length) { [] }
		@stacks.each_with_index do |stack, i|
			output[0][i] = stack.index
			Array.new(height) { |x| stack.load[x] }.each_with_index do |val, j|
				next if output[j+1].nil?
				output[j+1][i] = val
			end
		end
		
		str = ""
		columns = output.shift
		output.reverse.each_with_index do |x, i| 
			str += x.map{|x| x.nil? ? "   " : "[#{x}]"}.join(" ")
			str += "\n"
		end
		str += " #{columns.join("   ")}"
		puts str
	end
end

class Stack
	attr_accessor :index, :load
	def initialize(index)
		@index = index.to_i
		@load = []
	end

	def add(value)
		@load << value
	end

	def move(num_boxes, destination)
		num_boxes.times do
			destination.add(self.load.pop)
		end
	end
end

class StackCollection
	def initialize(indices)
		@stacks = indices.map {|x| Stack.new(x)}
	end

	def find(value)
		@stacks.detect { |x| x.index === value}
	end

	def each(&block)
		@stacks.each(&block)
	end

	def each_with_index(&block)
		@stacks.each_with_index(&block)
	end

	def length
		@stacks.size
	end

	def height
		@stacks.map{|x| x.load.size}.max
	end
end

class Direction
	def self.parse(direction)
		data = direction.match(/move (\d+) from (\d+) to (\d+)/)
		{ num_boxes: $1.to_i, source: $2.to_i, destination: $3.to_i }
	end

	def self.execute(direction, stacks)
		destination = stacks.find(direction[:destination])
		stack = stacks.find(direction[:source])
		stack.move(direction[:num_boxes], destination)
	end
end

grid = CargoGrid.new(input_part_1)

input_part_2.each do |line|
	direction = Direction.parse(line)
	Direction.execute(direction, grid.stacks)
end

grid.render