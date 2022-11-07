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
    [
      "version: #{ByteCrawler.read_uint32(pid)}"
    ]
  end
end
