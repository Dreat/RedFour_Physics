defmodule RocketryTest do
  use ExUnit.Case, async: true

  import Physics.Rocketry

  test "Earth's escape velocity should be calculated properly" do
    assert Planet.load[:earth].ev == 11.2
  end

  test "Mars' escape velocity should equal 5.1km/s" do
    assert Planet.load[:mars].ev == 5.1
  end

  test "Orbital acceleration for 100km height should be around 9.6" do
    assert orbital_acceleration(100) |> Calcs.to_nearest_tenth == 9.6
  end

  test "Orbital radius to achieve 4 hours orbital term should be around 526km" do
    assert calculate_orbital_radius(4) |> Calcs.to_nearest_tenth == 525.8
  end

  test "Orbital acceleration defaults to Earth" do
    x = orbital_acceleration(100)
    assert x == 9.519899476599884
  end

  test "Orbital acceleration for Jupiter" do
    x = orbital_acceleration(Planet.select[:jupiter], 100)
    assert x == 24.670096337229204
  end

  test "Orbital term at 100km for Saturn at 6000km" do
    x = orbital_term(Planet.select[:saturn], 6000)
    assert x == 4.9
  end

end
