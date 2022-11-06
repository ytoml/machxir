defmodule Machxir.MachO.LoadCommand.Routines do
  @moduledoc """
  Parsing LC_ROUTINES.
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
    init_address = ByteCrawler.read_uint32(pid) |> Utils.to_padded_hex32()
    init_module = ByteCrawler.read_uint32(pid) |> Utils.to_padded_hex32()

    [
      "init_address: #{init_address}",
      "init_module:  #{init_module}"
    ]

    # We will skip reserved bytes
  end
end
