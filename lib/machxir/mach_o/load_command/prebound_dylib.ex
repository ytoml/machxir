defmodule Machxir.MachO.LoadCommand.PreboundDylib do
  @moduledoc """
  Parsing LC_PREBOUND_DYLIB.
  """

  import Bitwise
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
    name_offset = ByteCrawler.read_uint32(pid)
    nmodules = ByteCrawler.read_uint32(pid)
    linkmod_offset = ByteCrawler.read_uint32(pid)
    ByteCrawler.read_rawbytes(pid, name_offset - 20) |> Utils.check_zero_or_empty(__MODULE__)

    name_size = linkmod_offset - name_offset
    name = LcStr.get_annotated_string(pid, name_size, name_offset, arch)

    linked_modules =
      ByteCrawler.take_all(pid)
      |> :binary.bin_to_list()
      |> Enum.with_index()
      |> Enum.map(fn {byte, i} ->
        0..7
        |> Enum.filter(&((byte >>> &1 &&& 1) == 1))
        |> Enum.map(&(&1 + i * 8))
      end)
      |> List.flatten()
      |> Enum.map(&Integer.to_string/1)
      |> Enum.join(",")
      |> LcStr.annotate(linkmod_offset)

    [
      "name:           #{name}",
      "nmodules:       #{nmodules}",
      "linked_modules: #{linked_modules}"
    ]
  end
end
