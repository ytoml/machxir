defmodule Machxir.MachO.LoadCommand.SourceVersion do
  @moduledoc """
  Parsing LC_SOURCE_VERSION.
  """

  alias Machxir.ByteCrawler

  @spec parse(pid) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid) do
    version = ByteCrawler.read_uint32(pid) |> version()

    [
      "version: #{version}"
    ]
  end

  defp version(int) do
    <<a::24, b::10, c::10, d::10, e::10>> = <<int::64>>
    "#{a}.#{b}.#{c}.#{d}.#{e}"
  end
end
