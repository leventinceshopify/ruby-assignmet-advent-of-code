def find_visited_points (start_position, end_position, moving_direction)

 # A variable used to ensure decreasing iteration with .upto method. Eg. 10.upto(5)
  mirror_value = start_position[moving_direction] > end_position[moving_direction] ? 2 : 0
  start_point_offset = start_position[moving_direction] > end_position[moving_direction] ? -1 : 1
  offset_value = start_position[moving_direction] > end_position[moving_direction] ? start_position[moving_direction] - end_position[moving_direction]  : 0
  mirror_counter = 0
  stationary_direction = (moving_direction + 1) % 2
  (start_position[moving_direction] + start_point_offset).upto(end_position[moving_direction] + 2 * offset_value) do |k|

      passedby_point = k - mirror_counter * mirror_value
      visited_point = [0, 0]
      visited_point[moving_direction] = passedby_point

      mirror_counter += 1
      visited_point[stationary_direction] = end_position[stationary_direction]

      # puts "Visited points: #{[visited_point[moving_direction], high_position[stationary_direction] }  "

      $hash_visited_points[visited_point] += 1

      if $hash_visited_points[visited_point] > 1
        total_distance = visited_point[0].abs + visited_point[1].abs
        puts "Total distane to center: #{total_distance}"
        is_solution_found = true
        break
      end
  end
end





input_file_name = "advent_of_code_input.txt"
if File.file?(input_file_name)
  steps_string  = File.open("advent_of_code_input.txt").read.to_s
else
  puts "PLEASE PROVIDE A VALID INPUT FILE"
end

steps = steps_string.split(", ")

# Create an empty hash to keep the distances travelled in each major direction
hash_steps = Hash.new(0)

# Create an empty hash to keep track of the points visited during the travel
# The solution will be reached when a point is visited for the second time.
$hash_visited_points = Hash.new(0)

# Traverse along this array to keep track of the direction
direction_array = ["North", "East", "South", "West"]

#the arrays to keep the data of important points for calculation
#the new coordinate after the steps were taken
current_position_coordinate = [0,0]
#the previous coordinate right before the steps were taken
previous_position_coordinate = [0,0]
#the coordinate after a step is taken (i.e. the visited coordinates)
current_visited_point_coordinate = [0,0]

#exit flag for the loops which is raised when the soluiton is found
is_solution_found = false

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
  # current direction is either "North", "East", "South" or  "West" based on the index
  current_direction = direction_array[index]
  #Add the new steps to the value of corresponding direction key in the hash
  hash_steps[current_direction] += number_of_steps

  # The coordinate of the current position in terms of N-S and E-W directions
  current_position_coordinate[0] = (hash_steps["North"] - hash_steps["South"])
  current_position_coordinate[1] = (hash_steps["East"] - hash_steps["West"])

  # puts "previous_position_coordinate : #{previous_position_coordinate}"

  case current_direction
    when "North"

      find_visited_points(previous_position_coordinate , current_position_coordinate, 0)

    # (previous_position_coordinate[0]+1).upto(current_position_coordinate[0]) do |passedby_point|
    #   current_visited_point_coordinate[0] = passedby_point
    #   current_visited_point_coordinate[1] = current_position_coordinate[1]
    #   puts "Visited points: #{current_visited_point_coordinate}"
    #   hash_visited_points[current_visited_point_coordinate] += 1
    #   if hash_visited_points[current_visited_point_coordinate] > 1
    #     total_distance = current_visited_point_coordinate[0].abs + current_visited_point_coordinate[1].abs
    #     puts "Total distane to center: #{total_distance}"
    #     is_solution_found = true
    #     break
    #   end
    #
    # end
    when "South"
      find_visited_points(previous_position_coordinate , current_position_coordinate , 0)


    # (previous_position_coordinate[0]-1).downto(current_position_coordinate[0]) do |passedby_point|
    #   current_visited_point_coordinate[0] = passedby_point
    #   current_visited_point_coordinate[1] = current_position_coordinate[1]
    #   puts "Visited points: #{current_visited_point_coordinate}"
    #   hash_visited_points[current_visited_point_coordinate] += 1
    #   if hash_visited_points[current_visited_point_coordinate] > 1
    #     total_distance = current_visited_point_coordinate[0].abs + current_visited_point_coordinate[1].abs
    #     puts "Total distane to center: #{total_distance}"
    #     is_solution_found = true
    #     break
    #   end
    # end

    when "East"

      find_visited_points(previous_position_coordinate , current_position_coordinate , 1)
    # (previous_position_coordinate[1]+1).upto(current_position_coordinate[1]) do |passedby_point|
    #   current_visited_point_coordinate[1] = passedby_point
    #   current_visited_point_coordinate[0] = current_position_coordinate[0]
    #   puts "Visited points: #{current_visited_point_coordinate}"
    #   hash_visited_points[current_visited_point_coordinate] += 1
    #   if hash_visited_points[current_visited_point_coordinate] > 1
    #     total_distance = current_visited_point_coordinate[0].abs + current_visited_point_coordinate[1].abs
    #     puts "Total distane to center: #{total_distance}"
    #     is_solution_found = true
    #     break
    #   end
    # end

    when "West"

      find_visited_points(previous_position_coordinate , current_position_coordinate , 1)
    # (previous_position_coordinate[1]-1).downto(current_position_coordinate[1]) do |passedby_point|
    #   current_visited_point_coordinate[1] = passedby_point
    #   current_visited_point_coordinate[0] = current_position_coordinate[0]
    #   puts "Visited points: #{current_visited_point_coordinate}"
    #   hash_visited_points[current_visited_point_coordinate] += 1
    #   if hash_visited_points[current_visited_point_coordinate] > 1
    #     total_distance = current_visited_point_coordinate[0].abs + current_visited_point_coordinate[1].abs
    #     puts "Total distane to center: #{total_distance}"
    #     is_solution_found = true
    #     break
    #   end
    # end
    end

    if is_solution_found
      puts "Solution found"
      break;
    end



  puts "current_position_coordinate : #{current_position_coordinate}"
  puts

  previous_position_coordinate = Array.new(current_position_coordinate)

end






# hash_points[current_position_coordinate] += 1

total_distance = (hash_steps["North"] - hash_steps["South"]).abs + (hash_steps["East"] - hash_steps["West"]).abs

puts hash_steps
puts total_distance

# Second part. the first location visited twice
