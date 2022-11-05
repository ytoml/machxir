defmodule Machxir.MachO.LoadCommand.Fvmlib do
  @moduledoc """
  fvmlib_command
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
    offset = ByteCrawler.read_uint32(pid)
    minor_version = ByteCrawler.read_uint32(pid)
    header_addr = ByteCrawler.read_uint32(pid) |> Utils.to_padded_hex32()
    ByteCrawler.read_rawbytes(pid, offset - 20) |> Utils.check_zero_or_empty(__MODULE__)
    name = LcStr.get_annotated_string(pid, offset, arch)

    [
      "name:          #{name}",
      "minor_version: #{minor_version}",
      "header_addr:   #{header_addr}"
    ]
  end
end
