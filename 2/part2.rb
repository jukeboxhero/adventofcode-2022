input = File.open("input.txt")
file_data = input.readlines.map(&:chomp)
input.close

round_points = []

play_key = {"X": 1, "Y": 2, "Z": 3}

file_data.each do |round|
	elf, result = round.split(' ')
	me = nil
	win, draw = false
	total_for_round = 0

	case elf 
	when "A"
		me = "Z" if result === "X"
		me = "X" if result === "Y"
		me = "Y" if result === "Z"
	when "B"
		me = "X" if result === "X"
		me = "Y" if result === "Y"
		me = "Z" if result === "Z"
	when "C"
		me = "Y" if result === "X"
		me = "Z" if result === "Y"
		me = "X" if result === "Z"
	end

	draw = true if result === "Y"
	win = true if result === "Z"

	total_for_round += play_key[me.to_sym]

	if win
		total_for_round += 6
	elsif draw
		total_for_round += 3
	end

	round_points << total_for_round
end

p round_points.sum