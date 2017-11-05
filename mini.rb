#!/usr/bin/env ruby
number_of_simulations = (ARGV[0] || 1).to_i
number_of_doors = [ARGV[1].to_i, 3].max
if ARGV[1] && ARGV[1].to_i < 3
  puts "Minimum number of doors is 3"
  puts "Runnig simulation with 3 doors"
  puts
end

CAR  = 'car'.freeze
GOAT = 'goat'.freeze

prizes         = [CAR].fill(GOAT, 1, number_of_doors-1).freeze
door_indexes   = (0...prizes.length).to_a.freeze

sticking_score = 0
changing_score = 0

number_of_simulations.times do
  doors = prizes.shuffle

  car_index    = doors.find_index(CAR)
  goat_indexes = door_indexes.reject{ |i| i == car_index }

  chosen_index       = door_indexes.sample
  goat_index_to_show = (goat_indexes.reject{ |i| i == chosen_index }).sample
  change_index       = (door_indexes.reject{ |i| [chosen_index, goat_index_to_show].include? i }).sample

  if doors[chosen_index] == CAR
    sticking_score += 1
  elsif doors[change_index] == CAR 
    changing_score += 1 
  end
end

puts "#{number_of_simulations} simulation(s) run"
puts "Score (sticking): #{sticking_score} (~#{(sticking_score.to_f*100/number_of_simulations).round(2)}%)"
puts "Score (changing): #{changing_score} (~#{(changing_score.to_f*100/number_of_simulations).round(2)}%)"
puts
