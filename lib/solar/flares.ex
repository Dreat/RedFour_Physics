defmodule Solar.Flare do

  defstruct [
    classification: :M,
    scale: 0,
    power: 0,
    is_deadly: false,
    date: nil
  ]

  def load(flares) do
    for flare <- flares, do: flare |> calculate_power |> calculate_deadliness
  end

  def calculate_power(flare) do
    factor = case flare.classification do
      :M ->  10
      :X -> 1000
      :C -> 1
    end
    %{flare | power: flare.scale * factor}
  end

  def no_eva(flares) do
    Enum.filter flares, fn(flare) ->
      (flare
       |> calculate_power
       |> calculate_deadliness).is_deadly
    end
  end

  def deadliest(flares) do
    Enum.map(flares, &(calculate_power(&1)))
      |> Enum.max
  end

  def calculate_deadliness(flare) do
    if flare.power > 1000 do
      %{flare | is_deadly: true}
    else
      %{flare | is_deadly: false}
    end
  end

  #chose other way just to show possibilities
  def total_flare_power(flares) do
    (for flare <- flares, do: calculate_power(flare).power)
      |> Enum.sum
  end

  def flare_list(flares) do
    for flare <- flares,
      flare_with_calculated_power <- [calculate_power(flare)],
      do: calculate_deadliness(flare_with_calculated_power)
  end
end
