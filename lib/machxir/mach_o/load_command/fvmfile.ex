defmodule Machxir.MachO.LoadCommand.Fvmfile do
  @moduledoc """
  Parsing LC_FVMFILE.
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
    header_addr = ByteCrawler.read_uint32(pid) |> Utils.to_padded_hex32()
    ByteCrawler.read_rawbytes(pid, offset - 16) |> Utils.check_zero_or_empty(__MODULE__)
    name = LcStr.get_annotated_string(pid, offset, arch)

    [
      "name:        #{name}",
      "header_addr: #{header_addr}"
    ]
  end
end
