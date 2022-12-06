input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

total = 0

file_data.each do |pair|
	assignment1, assignment2 = pair.split(',')
	bottom, top = assignment1.split('-').map(&:to_i)

	range1 = bottom..top

	bottom, top = assignment2.split('-').map(&:to_i)

	range2 = bottom..top

	total += 1 if range1.cover?(range2) || range2.cover?(range1)
end

p total