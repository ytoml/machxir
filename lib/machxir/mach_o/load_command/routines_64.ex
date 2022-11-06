defmodule Machxir.MachO.LoadCommand.Routines64 do
  @moduledoc """
  Parsing LC_ROUTINES_64.
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
    init_address = ByteCrawler.read_uint64(pid) |> Utils.to_padded_hex64()
    init_module = ByteCrawler.read_uint64(pid) |> Utils.to_padded_hex64()

    [
      "init_address: #{init_address}",
      "init_module:  #{init_module}"
    ]

    # We will skip reserved bytes
  end
end
