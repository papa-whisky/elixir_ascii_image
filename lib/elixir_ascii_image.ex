defmodule ElixirAsciiImage do
  @moduledoc """
  Documentation for ElixirAsciiImage.
  """

  @doc """
  Asciify an image

  ## Examples

      iex> ElixirAsciiImage.asciify(img_path)
      Successfully loaded image!
      Image size: 640 x 480
      :ok

  """
  def asciify(img_path) do
    img_info = img_info(img_path)
    IO.puts "Successfully loaded image!"
    IO.puts "Image size: #{img_info.width} x #{img_info.height}"
  end

  defp img_info(img_path) do
    img = Mogrify.open(img_path)
    img |> Mogrify.verbose
  end
end
