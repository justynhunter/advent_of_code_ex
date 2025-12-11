defmodule AdventOfCode.Solution.Year2025.Day02 do
  use AdventOfCode.Solution.SharedParse

  @impl true
  def parse(input) do
    input
    |> String.trim()
    |> String.split(",")
    |> Enum.map(fn range ->
      [from, to] = String.split(range, "-")
      %{from: String.to_integer(from), to: String.to_integer(to)}
    end)
  end

  defp num_of_digits(num), do: num_of_digits(div(num, 10), 1)
  defp num_of_digits(0, count), do: count
  defp num_of_digits(num, count), do: num_of_digits(div(num, 10), count + 1)

  defp add_num_digits(num), do: %{number: num, digits: num_of_digits(num)}

  defp even_digits(%{digits: digits}) do
    Integer.mod(digits, 2) == 0
  end

  defp doubles(num) do
    factor = 10 ** div(num.digits, 2)
    div(num.number, factor) == Integer.mod(num.number, factor)
  end

  defp process_range(range) do
    range.from..range.to
    |> Enum.map(&add_num_digits/1)
    |> Enum.filter(&even_digits/1)
    |> Enum.filter(&doubles/1)
    |> Enum.sum_by(& &1.number)
  end

  def part1(ranges) do
    ranges
    |> Enum.map(&process_range/1)
    |> Enum.sum()
  end

  def part2(_input) do
  end
end
