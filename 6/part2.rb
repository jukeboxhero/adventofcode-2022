input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

input_string = file_data.first

left = 0
right = 13

while input_string[left..right].split(//).uniq.size != 14
	left += 1
	right += 1
end

p right + 1
p input_string[left..right]