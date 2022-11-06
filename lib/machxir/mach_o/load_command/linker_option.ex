defmodule Machxir.MachO.LoadCommand.LinkerOption do
  @moduledoc """
  Parsing LC_LINKER_OPTION.
  """

  alias Machxir.ByteCrawler

  @spec parse(pid) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid) do
    count = ByteCrawler.read_uint32(pid)

    strings =
      ByteCrawler.take_all(pid) |> String.split("\0") |> Enum.filter(&(String.length(&1) > 0))

    [
      "count: #{count}",
      strings
    ]
  end
end
