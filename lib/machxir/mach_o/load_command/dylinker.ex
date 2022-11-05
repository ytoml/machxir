defmodule Machxir.MachO.LoadCommand.Dylinker do
  @moduledoc """
  Parsing LC_DYLINKER.
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
    ByteCrawler.read_rawbytes(pid, offset - 12) |> Utils.check_zero_or_empty(__MODULE__)
    name = LcStr.get_annotated_string(pid, offset, arch)

    [
      "name: #{name}"
    ]
  end
end
