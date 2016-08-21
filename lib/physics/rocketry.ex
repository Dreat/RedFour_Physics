defmodule Physics.Rocketry do

  import Calcs
  import Physics.Laws
  import Planets

  def escape_velocity(:earth) do
    earth
      |> escape_velocity
  end

  def escape_velocity(:mars) do
    mars
      |> escape_velocity
  end

  def escape_velocity(:moon) do
    moon
      |> escape_velocity
  end

  def escape_velocity(planet) when is_map(planet) do
    planet
      |> calculate_escape
      |> to_km
      |> to_nearest_tenth
  end

  def orbital_speed(height) do
    height
      |> orbital_speed(earth)
  end

  def orbital_speed(height, %{mass: mass, radius: _}) do
    newtons_gravitational_constant * mass / orbital_radius(height)
      |> square_root
  end

  def orbital_speed(height, :mars) do
    height
      |> orbital_speed(mars)
  end

  def orbital_speed(height, :moon) do
    height
      |> orbital_speed(moon)
  end

  def orbital_acceleration(height) do
    (orbital_speed(height) |> squared) / orbital_radius(height)
  end

  def orbital_term(height) do
    height
      |> orbital_term(earth)
  end

  def orbital_term(height, %{mass: mass, radius: _}) do
    4 * (:math.pi |> squared) * (orbital_radius(height) |> cubed) / (newtons_gravitational_constant * mass)
      |> square_root
      |> seconds_to_hours
  end

  def orbital_term(height, :mars) do
    height
      |> orbital_term(mars)
  end

  def orbital_term(height, :moon) do
    height
      |> orbital_term(moon)
  end

  def calculate_orbital_radius(time) do
    time
      |> calculate_orbital_radius(earth)
  end

  def calculate_orbital_radius(time, %{mass: mass, radius: _}) do
    newtons_gravitational_constant * mass * (time |> hours_to_seconds) / (4 * (:math.pi |> squared))
      |> cube_root
      |> to_km
  end

  def calculate_orbital_radius(time, :mars) do
    time
      |> calculate_orbital_radius(mars)
  end

  def calculate_orbital_radius(time, :moon) do
    time
      |> calculate_orbital_radius(moon)
  end


  defp calculate_escape(%{mass: mass, radius: radius}) do
    2 * newtons_gravitational_constant * mass / radius
      |> square_root
  end

  defp orbital_radius(height) do
    Planets.earth.radius + (height |> to_m)
  end
end
