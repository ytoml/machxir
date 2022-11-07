defmodule Machxir.MachO.LoadCommand.TwolevelHints do
  @moduledoc """
  Parsing LC_TWOLEVEL_HINTS.
  """

  alias Machxir.ByteCrawler
  alias Machxir.Utils

  @spec parse(pid) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid) do
    offset = ByteCrawler.read_int32(pid) |> Utils.to_padded_hex32()
    nhints = ByteCrawler.read_int32(pid)

    [
      "offset: #{offset}",
      "nhints: #{nhints}"
    ]
  end
end
