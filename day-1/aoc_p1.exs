defmodule AOC do
  def solve(filepath) do
    readFile(filepath)
      |> Enum.map(&sum_of_first_and_last_integer/1)
      |> Enum.reduce(0, fn line_value, acc -> acc + line_value end)
  end

  defp readFile(filepath) do
    {:ok, content} = File.read(filepath)

    lines = String.split(content, ~r/\r?\n/, trim: true)
    Enum.to_list(lines)
  end

  defp sum_of_first_and_last_integer(str) do
    # all digits
    regex = ~r/\d/

    regex_result = Regex.scan(regex, str)
    # [ [1], [2], [3], ... ]
    regex_matches = Enum.to_list(regex_result)
    # get nested value
    matches =
      regex_matches
      |> Enum.map(fn val -> hd(val) end)

    # first and last value from our list
    first_integer =
      hd(matches)

    last_integer =
      List.last(matches)

    number_string = first_integer <> last_integer
    String.to_integer(number_string)
  end
end

result = AOC.solve("./input")
IO.puts("Final Answer: #{result}")
