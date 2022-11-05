defmodule Machxir.MachO.LoadCommand.FilesetEntry do
  @moduledoc """
  Parsing LC_FILESET_ENTRY.
  """

  alias Machxir.ByteCrawler
  alias Machxir.MachO.LcStr
  alias Machxir.Utils

  @spec parse(pid, :mach | :mach64) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid, arch) do
    vmaddr = ByteCrawler.read_uint64(pid) |> Utils.to_padded_hex64()
    fileoff = ByteCrawler.read_uint64(pid) |> Utils.to_padded_hex64()
    offset = ByteCrawler.read_uint32(pid)
    # reserved
    ByteCrawler.read_uint32(pid) |> Utils.check_zero_or_empty(__MODULE__)
    ByteCrawler.read_rawbytes(pid, offset - 32) |> Utils.check_zero_or_empty(__MODULE__)
    entry_id = LcStr.get_annotated_string(pid, offset, arch)

    [
      "vmaddr:   #{vmaddr}",
      "fileoff:  #{fileoff}",
      "entry_id: #{entry_id}"
    ]
  end
end
