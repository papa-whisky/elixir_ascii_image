defmodule Mix.Tasks.Asciify do
  use Mix.Task

  @shortdoc "Runs the ElixirAsciiImage.hello/0 function"
  def run(_) do
    ElixirAsciiImage.hello
  end
end
