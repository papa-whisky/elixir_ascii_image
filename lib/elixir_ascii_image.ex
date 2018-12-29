defmodule ElixirAsciiImage do
  @moduledoc """
  Documentation for ElixirAsciiImage.
  """

  @doc """
  Asciify an image

  ## Examples

      iex> ElixirAsciiImage.asciify(img_path)
      Successfully constructed brightness matrix!
      Brightness matrix size: 640 x 480
      Iterating through pixel brightnesses:
      68
      12
      # etc...
      :ok

  """
  def asciify(img_path) do
    img_info = img_info(img_path)
    IO.puts "Successfully constructed brightness matrix!"
    IO.puts "Brightness matrix size: #{img_info.width} x #{img_info.height}"
    IO.puts "Iterating through pixel brightnesses:"

    Enum.each brightness_matrix(img_path), fn row ->
      Enum.each row, &(IO.puts &1)
    end
  end

  defp img_info(img_path) do
    img = Mogrify.open(img_path)
    img |> Mogrify.verbose
  end

  defp brightness_matrix(img_path) do
    pixel_matrix(img_path)
    |> Enum.map(&row_brightness/1)
  end

  defp row_brightness(row) do
    row
    |> Enum.map(&(Enum.sum(&1) / 3))
    |> Enum.map(&round/1)
  end

  defp pixel_matrix(img_path) do
    {raw_pixel_data, 0} = System.cmd("magick", [img_path, "sparse-color:"])

    raw_pixel_data
    |> String.split
    |> Enum.map(&(String.split(&1, ",", parts: 3)))
    |> Enum.reduce([], &pixels_to_rows/2)
    |> Enum.map(&convert_row/1)
  end

  defp pixels_to_rows(pixel, acc) do
    row = String.to_integer Enum.at(pixel, 1)

    acc = if Enum.at(acc, row) == nil do
      acc ++ [[]]
    else
      acc
    end

    List.replace_at(acc, row, Enum.at(acc, row) ++ [pixel])
  end

  defp convert_row(row) do
    row |> Enum.map(&extract_rgb/1)
  end

  defp extract_rgb(pixel) do
    pixel
    |> Enum.at(-1)
    |> String.slice(5..-2)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
