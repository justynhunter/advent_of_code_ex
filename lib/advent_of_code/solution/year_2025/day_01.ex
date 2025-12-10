defmodule AdventOfCode.Solution.Year2025.Day01 do
  use AdventOfCode.Solution.SharedParse

  @impl true
  def parse(input) do
    input
    |> String.split()
    |> Enum.map(fn
      "L" <> n -> -String.to_integer(n)
      "R" <> n -> String.to_integer(n)
    end)
    |> Stream.scan(%{position: 50}, &rotate/2)
    |> Enum.to_list()
  end

  defp rotate(rotation, %{position: position}) do
    %{
      position: Integer.mod(position + rotation, 100),
      zero_visits: count_zero(position, rotation)
    }
  end

  defp count_zero(position, rotation) when rotation > 0, do: zero_visits(rotation, 100 - position)
  defp count_zero(position, rotation) when rotation < 0, do: zero_visits(abs(rotation), position)

  defp zero_visits(rotation, 0), do: div(rotation, 100)
  defp zero_visits(rotation, d_zero) when rotation >= d_zero, do: 1 + div(rotation - d_zero, 100)
  defp zero_visits(_, _), do: 0

  def part1(rotations), do: Enum.count(rotations, &(&1.position == 0))
  def part2(rotations), do: Enum.sum_by(rotations, & &1.zero_visits)
end
