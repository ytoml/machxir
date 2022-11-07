defmodule Machxir.MachO.LoadCommand.Symtab do
  @moduledoc """
  Parsing LC_SYMTAB.
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
    symoff = ByteCrawler.read_int32(pid) |> Utils.to_padded_hex32()
    nsyms = ByteCrawler.read_int32(pid)
    stroff = ByteCrawler.read_int32(pid) |> Utils.to_padded_hex32()
    strsize = ByteCrawler.read_int32(pid) |> Utils.to_padded_hex32()

    [
      "symoff:  #{symoff}",
      "nsyms:   #{nsyms}",
      "stroff:  #{stroff}",
      "strsize: #{strsize}"
    ]
  end
end
