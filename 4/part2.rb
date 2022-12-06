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

	total += 1 unless range1.to_a.intersection(range2.to_a).empty?
end

p total