defmodule RocketryTest do
  use ExUnit.Case

  test "Earth's escape velocity should be calculated properly" do
    assert Physics.Rocketry.escape_velocity(:earth) == 11.2
  end

  test "Planet with 8x mass and 2x radius should have twice the escape velocity" do
    assert Physics.Rocketry.escape_velocity(%{mass: 5.972e24 * 8, radius: 6.371e6 * 2}) == 22.4
  end

  test "Mars' escape velocity should equal 5.1km/s" do
    assert Physics.Rocketry.escape_velocity(:mars) == 5.1
  end

  test "Moon's escape velocity should equal 2.4km/s" do
    assert Physics.Rocketry.escape_velocity(:moon) == 2.4
  end

  test "Orbital acceleration for 100km height should be around 9.6" do
    assert Physics.Rocketry.orbital_acceleration(100) |> Calcs.to_nearest_tenth == 9.6
  end

end
