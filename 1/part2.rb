input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

elf_inventory_strings = file_data.map { |x| x === "" ? " " : x }.join(';').split("; ;")
elf_inventories = elf_inventory_strings.map {|x| x.split(';')}

sums = []
elf_inventories.each do |inventory|
	inventory = inventory.map(&:to_i)
	
	sums << inventory.sum


end

p sums.max(3).sum
