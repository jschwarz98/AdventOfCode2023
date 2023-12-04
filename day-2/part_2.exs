defmodule AOC do
  def solve(filepath) do
    readFile(filepath)
      |> Enum.map(&transform_to_tuple/1)
      |> Enum.map(&calculate_minimum_cubes/1)
      |> Enum.map(&calculate_magnitude/1)
      |> Enum.reduce(0, fn row, acc -> acc + row end)
  end

  defp readFile(filepath) do
    case File.read(filepath) do
      {:ok, content} -> Enum.to_list(String.split(content, ~r/\r?\n/, trim: true))
      _ -> Enum.to_list([""])
    end
  end

  defp transform_to_tuple(str) do
    # Game 1: 1 red, 2 green; 4 blue, 1 red
    # Split anhand vom ':' für Game-ID und danach können die einzelnen Spielwerte anhand von ; gesplittet werden
    # einzelne Spiele: 1 red, 4 green, ... werden am ',' gesplittet und das result dann nochmal am " " um die zahl und farbe zu erhalten
    # -> daraus ein tupel machen mit red, green, blue werten
    [game_id, games] = String.split(str, ~r/:/, trim: true)
    [_, game_id] = String.split(game_id, ~r/ /, trim: true)

    games = transform_games_list_to_game_tuple(games)

    {String.to_integer(game_id), games}
  end

  defp transform_games_list_to_game_tuple(str) do
    games =
      String.split(str, ~r/;/, trim: true)
      |> Enum.map(&transform_one_game_to_tuple/1)

    games
  end

  defp transform_one_game_to_tuple(str) do
    # red, green, blue
    game =
      String.split(str, ~r/,/, trim: true)
      |> Enum.reduce({0, 0, 0}, fn str, acc ->
        [amount, color] = String.split(str, ~r/ /, trim: true)

        acc =
          case color do
            "red" ->
              put_elem(acc, 0, String.to_integer(amount))

            "green" ->
              put_elem(acc, 1, String.to_integer(amount))

            "blue" ->
              put_elem(acc, 2, String.to_integer(amount))

            _ ->
              IO.puts("unknown color: " <> color)
              acc
          end

        acc
      end)

    game
  end

  defp calculate_minimum_cubes(game) do
    {_, games} = game

      games
      |> Enum.reduce({0, 0, 0}, fn cubes, acc ->
        {r, g, b} = cubes

        # r g b setzen falls notwendig
        acc =
          if elem(acc, 0) < r do
            put_elem(acc, 0, r)
          else
            acc
          end

        acc =
          if elem(acc, 1) < g do
            put_elem(acc, 1, g)
          else
            acc
          end

        acc =
          if elem(acc, 2) < b do
            put_elem(acc, 2, b)
          else
            acc
          end
        acc
      end)
  end

  defp calculate_magnitude(cubes) do
    elem(cubes, 0) * elem(cubes, 1) * elem(cubes, 2)
  end
end

result = AOC.solve("./input")
IO.puts("Final Answer: #{result}")
