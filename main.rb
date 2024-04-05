def calculate_fuel_for_launch(mass, gravity)
  fuel_mass = mass * gravity * 0.042 - 33

  return 0 if fuel_mass.negative?

  fuel_mass.to_i + calculate_fuel_for_launch(fuel_mass.to_i, gravity)
end

def calculate_fuel_for_landing(mass, gravity)
  fuel_mass = mass * gravity * 0.033 - 42

  return 0 if fuel_mass.negative?
  fuel_mass.to_i + calculate_fuel_for_landing(fuel_mass.to_i, gravity)
end

def operate(operation_mass, flight)
  flight_type = flight[0]
  fuel_mass_needed_for_flight = 0

  case flight_type
  when :launch
    fuel_mass_needed_for_flight = calculate_fuel_for_launch(operation_mass, flight[1])
  when :land
    fuel_mass_needed_for_flight = calculate_fuel_for_landing(operation_mass, flight[1])
  else
    throw("There is an unexpected flight type found: #{flight[0]}")
  end

  fuel_mass_needed_for_flight
end

def calculate_fuel(mass, flight_route) 
  total_fuel_needed = 0
  flight_route.reverse!

  flight_route.each do |flight|
    total_fuel_needed += operate(mass + total_fuel_needed, flight)
  end
  p "Here is the total amount of fuel you used: #{total_fuel_needed} kg"
end

# Apollo 11
calculate_fuel(28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]])

# Mission on Mars:
calculate_fuel(14606, [[:launch, 9.807], [:land, 3.711], [:launch, 3.711], [:land, 9.807]])

# Passenger ship:
calculate_fuel(75432, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 3.711], [:launch, 3.711], [:land, 9.807]])
