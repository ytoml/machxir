defmodule Machxir.MachO.LoadCommand.Segment64 do
  @moduledoc """
  Parsing LC_SEGMENT_64.
  """

  alias Machxir.ByteCrawler
  alias Machxir.MachO.SectionFlags
  alias Machxir.Utils

  @spec parse(pid, :describe | :format) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid, opt) do
    segname = ByteCrawler.read_rawbytes(pid, 16)
    vmaddr = ByteCrawler.read_uint64(pid) |> Utils.to_padded_hex64()
    vmsize = ByteCrawler.read_uint64(pid) |> Utils.to_padded_hex64()
    fileoff = ByteCrawler.read_uint64(pid) |> Utils.to_padded_hex64()
    filesize = ByteCrawler.read_uint64(pid) |> Utils.to_padded_hex64()
    maxprot = ByteCrawler.read_int32(pid)
    initprot = ByteCrawler.read_int32(pid)
    nsects = ByteCrawler.read_int32(pid)
    flags = ByteCrawler.read_uint32(pid) |> SectionFlags.parse(opt)

    # TODO: read sections?
    [
      "segname:  #{segname}",
      "vmaddr:   #{vmaddr}",
      "vmsize:   #{vmsize}",
      "fileoff:  #{fileoff}",
      "filesize: #{filesize}",
      "maxprot:  #{maxprot}",
      "initprot: #{initprot}",
      "nsects:   #{nsects}",
      "flags:",
      flags
    ]
  end
end
