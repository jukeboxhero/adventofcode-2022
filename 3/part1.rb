input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

priorities = []

file_data.each do |rucksack|
	compartment_capacity = rucksack.size / 2
	compartment_left = rucksack[0...compartment_capacity]
	compartment_right = rucksack[compartment_capacity..-1]

	common = compartment_left.split('').intersection(compartment_right.split('')).first
	priorities << if /[[:upper:]]/.match(common)
		common.bytes.first - 64 + 26
	else
		common.bytes.first - 96
	end
end

p priorities.sum
