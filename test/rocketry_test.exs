defmodule RocketryTest do
  use ExUnit.Case

  test "Earth's escape velocity should be calculated properly" do
    assert Physics.Rocketry.escape_velocity(:earth) == 11.2
  end

  test "Planet with 8x mass and 2x radius should have twice the escape velocidy" do
    assert Physics.Rocketry.escape_velocity(%{mass: 5.972e24 * 8, radius: 6.371e6 * 2}) == 22.4
  end
end
