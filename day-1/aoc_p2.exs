defmodule AOC do
  def solve(filepath) do
    lines = readFile(filepath)

    result =
      lines
      |> Enum.map(&replace_number_strings/1)
      |> Enum.map(&sum_of_first_and_last_integer/1)
      |> Enum.reduce(0, fn line_value, acc -> acc + line_value end)

    result
  end

  defp readFile(filepath) do
    case File.read(filepath) do
      {:ok, content} -> Enum.to_list(String.split(content, ~r/\r?\n/, trim: true))
      _ -> Enum.to_list([""])
    end
  end

  defp sum_of_first_and_last_integer(str) do
    # all digits
    regex = ~r/\d/

    # [ [1], [2], [3], ... ]
    matches =
      Regex.scan(regex, str)
      |> Enum.to_list(regex_result)
      |> Enum.map(fn val -> hd(val) end)

    first_integer = hd(matches)
    last_integer = List.last(matches)

    String.to_integer(first_integer <> last_integer)
  end

  defp replace_number_strings(string) do
    string = String.replace(string, "one", "one1one", global: true)
    string = String.replace(string, "two", "two2two", global: true)
    string = String.replace(string, "three", "three3three", global: true)
    string = String.replace(string, "four", "four4four", global: true)
    string = String.replace(string, "five", "five5five", global: true)
    string = String.replace(string, "six", "six6six", global: true)
    string = String.replace(string, "seven", "seven7seven", global: true)
    string = String.replace(string, "eight", "eight8eight", global: true)
    string = String.replace(string, "nine", "nine9nine", global: true)

    string
  end
end

result = AOC.solve("./input")
IO.puts("Final Answer: #{result}")
