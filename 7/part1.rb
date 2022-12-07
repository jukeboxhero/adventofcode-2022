input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

class Parser
	attr_accessor :tree, :position, :folder_breakdown
	def initialize(data)
		@tree = []
		@position = nil
		@data = data
		@line_iterator = 0
		@folder_breakdown = []

		while @data[@line_iterator]
			
			parse_line(@data[@line_iterator])
			@line_iterator += 1
		end
	end

	def parse_line(line)
		line.split(//).each_with_index do |char, i|
			if char == '$' && i == 0
				process_command(line[(i+1)..-1])
			end
		end
	end

	def process_command(cmd)
		cmd = cmd.strip

		command, argument = cmd.split(" ")
		
		if ["ls", "cd"].include?(command)
			self.send(command, argument)
		end
	end

	def parse_element(element)
		left, right = element.split(' ')

		if left == 'dir'
			return { type: 'dir', name: right, children: [], parent: @position, size: 0 }
		else
			return { type: 'file', name: right, size: left, parent: @position }
		end
	end

	def add_size(dir, size)
		return if dir.nil?
		dir[:size] += size.to_i
		add_size(dir[:parent], size.to_i)
	end

	def cd(arg)
		if arg == '/'
			@tree[0] ||= { type: 'dir', name: '/',children: [], parent: nil, size: 0 }
			@position = @tree[0]
		else
			# change directory

			if arg == '..'
				@position = @position[:parent]
				return
			end
			
			@position = @position[:children].detect{ |x| x[:name] == arg}
		end
	end

	def ls(arg)
		output = []
		@line_iterator += 1
		
		while @data[@line_iterator][0] != '$'
			element = parse_element(@data[@line_iterator])
			add_size(element[:parent], element[:size]) if element[:type] == 'file'
			output << element
			@line_iterator += 1
			break if @data[@line_iterator].nil?
		end
		@line_iterator -= 1
		
		@position[:children] = output
	end

	def folder_size(tree=@tree)
		out = []
		tree.each do |element|
			if element[:type] == 'file'
				out << element[:size].to_i
			else
				out += folder_size(element[:children]) unless element[:children].empty?
			end
		end
		out
	end

	def draw_tree(tree=@tree, depth=0)
		output = ''
		tree.each do |element|
			output += ("  " * depth);
			output += "- #{element[:name]} (#{element[:type]}#{", size=#{element[:size]}"  if element[:type] == 'file'})"
			output += "\n"
			next unless element[:type] == 'dir' && !element[:children].empty?
			@folder_breakdown << element[:size]
			output += draw_tree(element[:children], depth + 1)
		end
		output
	end
end

parser = Parser.new(file_data)
puts parser.draw_tree
p parser.folder_breakdown.filter {|x| x < 100000 }.sum

free = 30000000 - (70000000 - parser.folder_size.sum)

p parser.folder_breakdown.filter {|s| s >= free }.min

