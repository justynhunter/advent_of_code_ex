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

  defp num_of_digits(num), do: num |> Integer.digits() |> Enum.count()

  defp add_num_digits(num), do: %{number: num, digits: num_of_digits(num)}

  defp even_digits(%{digits: digits}) do
    Integer.mod(digits, 2) == 0
  end

  defp doubles(num) do
    factor = 10 ** div(num.digits, 2)
    div(num.number, factor) == Integer.mod(num.number, factor)
  end

  defp process_part1(range) do
    range.from..range.to
    |> Enum.map(&add_num_digits/1)
    |> Enum.filter(&even_digits/1)
    |> Enum.filter(&doubles/1)
    |> Enum.sum_by(& &1.number)
  end

  defp factors_of(n) do
    digits = num_of_digits(n)

    %{
      number: n,
      factors: Enum.filter(1..digits, &(rem(digits, &1) == 0)) |> Enum.filter(&(digits / &1 >= 2))
    }
  end

  defp not_uniq(nums) do
    nums |> Enum.uniq() |> length() <= 1
  end

  defp mark_repeats(n) do
    %{
      number: n.number,
      factors: n.factors,
      repeated:
        Enum.map(n.factors, fn factor ->
          n.number
          |> Integer.digits()
          |> Enum.chunk_every(factor)
          |> Enum.map(&Integer.undigits/1)
          |> (fn x ->
                if not_uniq(x) do
                  n.number
                else
                  0
                end
              end).()
        end)
        |> Enum.uniq()
        |> Enum.sum()
    }
  end

  defp process_part2(range) do
    range.from..range.to
    |> Enum.map(&factors_of/1)
    |> Enum.map(&mark_repeats/1)
    |> Enum.sum_by(& &1.repeated)
  end

  def part1(ranges) do
    ranges
    |> Enum.map(&process_part1/1)
    |> Enum.sum()
  end

  def part2(ranges) do
    ranges
    |> Enum.map(&process_part2/1)
    |> Enum.sum()
  end
end
