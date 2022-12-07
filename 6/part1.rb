input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

input_string = file_data.first

left = 0
right = 3

while input_string[left..right].split(//).uniq.size != 4
	left += 1
	right += 1
end

p right + 1