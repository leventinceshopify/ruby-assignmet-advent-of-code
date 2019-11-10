
input_file_name = "advent_of_code_input.txt"
if File.file?(input_file_name)
  steps_string  = File.open("advent_of_code_input.txt").read.to_s
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end

 # steps_string = "R4, R1, L2, R1, L1, L1, R1, L5, R1, R5, L2, R3, L3, L4, R4, R4, R3, L5, L1, R5, R3, L4, R1, R5, L1, R3, L2, R3, R1, L4, L1, R1, L1, L5, R1, L2, R2, L3, L5, R1, R5, L1, R188, L3, R2, R52, R5, L3, R79, L1, R5, R186, R2, R1, L3, L5, L2, R2, R4, R5, R5, L5, L4, R5, R3, L4, R4, L4, L4, R5, L4, L3, L1, L4, R1, R2, L5, R3, L4, R3, L3, L5, R1, R1, L3, R2, R1, R2, R2, L4, R5, R1, R3, R2, L2, L2, L1, R2, L1, L3, R5, R1, R4, R5, R2, R2, R4, R4, R1, L3, R4, L2, R2, R1, R3, L5, R5, R2, R5, L1, R2, R4, L1, R5, L3, L3, R1, L4, R2, L2, R1, L1, R4, R3, L2, L3, R3, L2, R1, L4, R5, L1, R5, L2, L1, L5, L2, L5, L2, L4, L2, R3"

steps = steps_string.split(", ")

# Create an empty hash to keep the distances travelled in each major direction
hash_steps = Hash.new(0)

# Traverse along this array to keep track of the direction
direction_array = ["North", "East", "South", "West"]

#initially we are facing North
index = 0

steps.each do |k|
  #if the input matches with the pattern
  if k =~ /([LR]?)(\d+)/
    # if Right turn, progress over the direction array Clockwise, other wise if it is Left go anti clockwise
    index =   $1 == "R" ?    (index + 1) % 4 :  (index -1 + 4) % 4
    number_of_steps = $2.to_i
  else
    raise "Bad input #{k}"
  end
 # current direction is either "North", "East", "South" or "West" based on the index
 current_direction = direction_array[index]
 #Add the new steps to the value of corresponding direction key in the hash
 hash_steps[current_direction] += number_of_steps
end
# total distance is the block distance calculated by the aggregation of steps taken to four direction
total_distance = (hash_steps["North"] - hash_steps["South"]).abs + (hash_steps["East"] - hash_steps["West"]).abs

puts hash_steps
puts total_distance

# Second part. the first location visited twice
