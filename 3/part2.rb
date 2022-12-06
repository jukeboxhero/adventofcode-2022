input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

priorities = []

file_data.each_slice(3) do |group|
	elf1, elf2, elf3 = group.map { |x| x.split('') }

	common = elf1.intersection(elf2).intersection(elf3).first
	
	priorities << if /[[:upper:]]/.match(common)
		common.bytes.first - 64 + 26
	else
		common.bytes.first - 96
	end
end

p priorities.sum
