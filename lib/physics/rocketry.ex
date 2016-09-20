defmodule Physics.Rocketry do

  import Calcs
  import Physics.Laws, only: [newtons_gravitational_constant: 0]
  import Planet

  @earth Planet.select[:earth]

  def calculate_orbital_radius(time), do: calculate_orbital_radius(@earth, time)
  def calculate_orbital_radius(planet, time) do
    newtons_gravitational_constant * planet.mass * (time |> hours_to_seconds) / (4 * (:math.pi |> squared))
      |> cube_root
      |> to_km
  end

  def orbital_acceleration(height), do: orbital_acceleration(@earth,height)
  def orbital_acceleration(planet, height) do
    (orbital_speed(planet, height) |> squared) / orbital_radius(planet, height)
  end

  def orbital_term(height), do: orbital_term(@earth, height)
  def orbital_term(planet, height) do
    4 * (:math.pi |> squared) * (orbital_radius(planet,height) |> cubed) / (newtons_gravitational_constant * planet.mass)
      |> square_root
      |> seconds_to_hours
  end

  def orbital_speed(height), do: orbital_speed(@earth,height)
  def orbital_speed(planet,height) do
    newtons_gravitational_constant * planet.mass / orbital_radius(planet, height)
      |> square_root
  end

  defp orbital_radius(planet, height) do
    planet.radius + (height |> to_m)
  end

end
