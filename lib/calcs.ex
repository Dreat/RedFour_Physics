defmodule Calcs do
  def to_nearest_tenth(val) do
    Float.ceil(val, 1)
  end

  def to_km(velocity) do
    velocity / 1000
  end

  def to_m(height) do
    height * 1000
  end

  def square_root(val) do
    :math.sqrt(val)
  end

  def squared(val) do
    val * val
  end

  def cubed(val) do
    val * val * val
  end

  def seconds_to_hours(time) do
    time / 3600 |> to_nearest_tenth 
  end

end
