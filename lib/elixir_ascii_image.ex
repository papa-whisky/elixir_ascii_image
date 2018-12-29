defmodule ElixirAsciiImage do
  @moduledoc """
  Documentation for ElixirAsciiImage.
  """
  @ascii_list "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~i!lI;:,\"^`"

  @doc """
  Asciify an image

  ## Examples

      iex> ElixirAsciiImage.asciify(img_path)
      # => Prints ASCII-ified version of image at img_path to standard output
      :ok

  """
  def asciify(img_path) do
    Enum.each ascii_matrix(img_path), fn row ->
      IO.puts Enum.join(row)
    end
  end

  defp img_info(img_path) do
    img = Mogrify.open(img_path)
    img |> Mogrify.verbose
  end

  defp ascii_matrix(img_path) do
    brightness_matrix(img_path)
    |> Enum.map(&ascii_character/1)
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

  defp ascii_character(row) do
    row
    |> Enum.map(&brightness_to_ascii/1)
  end

  defp brightness_to_ascii(value) do
    fraction = value / 255
    character_index = round(65 * fraction) - 1
    character = String.slice(@ascii_list, character_index, 1)
    Enum.join [character, character, character]
  end

  defp pixel_matrix(img_path) do
    {raw_pixel_data, 0} = System.cmd("magick", [img_path, "-resize", "250", "sparse-color:"])

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
