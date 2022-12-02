input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

round_points = []

play_key = {"X": 1, "Y": 2, "Z": 3}

file_data.each do |round|
	elf, me = round.split(' ')
	win = false
	draw = false
	total_for_round = 0

	case elf 
	when "A"
		win = true if me === "Y"
		draw = true if me === "X"
	when "B"
		win = true if me === "Z"
		draw = true if me === "Y"
	when "C"
		win = true if me === "X"
		draw = true if me === "Z"
	end

	total_for_round += play_key[me.to_sym]

	if win
		total_for_round += 6
	elsif draw
		total_for_round += 3
	end

	round_points << total_for_round
end

p round_points.sum