input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

elf_inventory_strings = file_data.map { |x| x === "" ? " " : x }.join(';').split("; ;")
elf_inventories = elf_inventory_strings.map {|x| x.split(';')}

output = 0
elf_inventories.each do |inventory|
	inventory = inventory.map(&:to_i)
	output = [output, inventory.sum].max
end

p output
