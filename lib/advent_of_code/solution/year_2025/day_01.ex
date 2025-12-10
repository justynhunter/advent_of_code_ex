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
    |> Enum.reduce(%{position: 50, zero_visits: 0}, &rotate/2)
  end

  defp rotate(rotation, %{position: position, zero_visits: zero_visits}) do
    %{
      position: Integer.mod(position + rotation, 100),
      zero_visits:
        case Integer.mod(position + rotation, 100) do
          0 -> zero_visits + 1
          _ -> zero_visits
        end
    }
  end

  def part1(rotations), do: rotations.zero_visits

  def part2(_input) do
  end
end
