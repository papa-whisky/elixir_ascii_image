defmodule Mix.Tasks.Asciify do
  @moduledoc """
  A Mix Task to print an ascii-fied image to standard output.
  """
  use Mix.Task

  @shortdoc "Runs the ElixirAsciiImage.asciify/1 function"
  def run(args) do
    ElixirAsciiImage.asciify List.first(args)
  end
end
