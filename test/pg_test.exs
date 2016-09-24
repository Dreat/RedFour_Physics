defmodule PGTest do
  use ExUnit.Case
  use Timex

  setup do
    flares = [
      %Solar.Flare{classification: :X, scale: 99, date: Timex.to_date({1859, 8, 29})},
      %Solar.Flare{classification: :M, scale: 5.8, date: Timex.to_date({2015, 1, 12})},
      %Solar.Flare{classification: :M, scale: 1.2, date: Timex.to_date({2015, 2, 9})},
      %Solar.Flare{classification: :C, scale: 3.2, date: Timex.to_date({2015, 4, 18})},
      %Solar.Flare{classification: :M, scale: 83.6, date: Timex.to_date({2015, 6, 23})},
      %Solar.Flare{classification: :C, scale: 2.5, date: Timex.to_date({2015, 7, 4})},
      %Solar.Flare{classification: :X, scale: 72, date: Timex.to_date({2012, 7, 23})},
      %Solar.Flare{classification: :X, scale: 45, date: Timex.to_date({2003, 11, 4})}
    ]
    {:ok, data: flares}
  end

  test "Connecting with postgrex", %{data: flares} do
    {:ok, pid} = Postgrex.Connection.start_link(hostname: "localhost", database: "redfour", username: "redfour", password: "redfour")

    sql = """
      insert into solar_flares(classification, scale, date)
      values($1, $2, $3);
      """

    res = Enum.map flares, fn(flare) ->
      ts = %Postgrex.Timestamp{year: flare.date.year, month: flare.date.month, day: flare.date.day}
      Postgrex.Connection.query!(pid, sql, [Atom.to_string(flare.classification), flare.scale, ts])
    end

    IO.inspect res
    Postgrex.Connection.stop(pid)
  end
end
