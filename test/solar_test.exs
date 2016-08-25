defmodule SolarTest do
  use ExUnit.Case
  use Timex

  setup do
    flares = [
      %{classification: :X, scale: 99, date: Timex.to_date({1859, 8, 29})},
      %{classification: :M, scale: 5.8, date: Timex.to_date({2015, 1, 12})},
      %{classification: :M, scale: 1.2, date: Timex.to_date({2015, 2, 9})},
      %{classification: :C, scale: 3.2, date: Timex.to_date({2015, 4, 18})},
      %{classification: :M, scale: 83.6, date: Timex.to_date({2015, 6, 23})},
      %{classification: :C, scale: 2.5, date: Timex.to_date({2015, 7, 4})},
      %{classification: :X, scale: 72, date: Timex.to_date({2012, 7, 23})},
      %{classification: :X, scale: 45, date: Timex.to_date({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end

  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end

  test "Classification X flare's scale should be multiplied by 1k" do
    assert Solar.power(%{classification: :X, scale: 99, date: Timex.to_date({1859, 8, 29})}) == 99000
  end

  test "Classification M flare's scale should be multiplied by 10" do
    assert Solar.power(%{classification: :M, scale: 5.8, date: Timex.to_date({2015, 1, 12})}) == 58
  end

  test "Classification C flare's scale should remain unchanged" do
    assert Solar.power(%{classification: :C, scale: 2.5, date: Timex.to_date({2015, 7, 4})}) == 2.5
  end

  test "We should have only 3 really dangerous flares", %{data: flares} do
    assert length(Solar.no_eva(flares)) == 3
  end

  test "Deadliest should return the power of the strongest flare recorded", %{data: flares} do
    assert Solar.deadliest(flares) == 99000
  end

  test "Sum of solar flares should be calculated properly", %{data: flares} do
    assert Solar.total_flare_power(flares) == 99000 + 58 + 12 + 3.2 + 836 + 2.5 + 72000 + 45000
  end

  test "A list of flares should be formatted properly", %{data: flares} do
  result = Solar.flare_list(flares)
  assert result == [
    %{power: 99000, is_deadly: true},
    %{power: 58.0, is_deadly: false},
    %{power: 12.0, is_deadly: false},
    %{power: 3.2, is_deadly: false},
    %{power: 836.0, is_deadly: false},
    %{power: 2.5, is_deadly: false},
    %{power: 72000, is_deadly: true},
    %{power: 45000, is_deadly: true}
 ]
end

end
