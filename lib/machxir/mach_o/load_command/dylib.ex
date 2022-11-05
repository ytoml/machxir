defmodule Machxir.MachO.LoadCommand.Dylib do
  @moduledoc """
  Parsing LC_DYLIB.
  """

  alias Machxir.ByteCrawler
  alias Machxir.MachO.LcStr
  alias Machxir.Utils

  @spec parse(pid, :mach | :mach64, :describe | :format) :: [String.t() | list]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid, arch, opt) do
    offset = ByteCrawler.read_uint32(pid)
    timestamp = ByteCrawler.read_uint32(pid) |> timestamp(opt)
    current_version = ByteCrawler.read_uint32(pid)
    compatible_version = ByteCrawler.read_uint32(pid)
    ByteCrawler.read_rawbytes(pid, offset - 24) |> Utils.check_zero_or_empty(__MODULE__)
    name = LcStr.get_annotated_string(pid, offset, arch)

    [
      "name:               #{name}",
      "timestamp:          #{timestamp}",
      "current_version:    #{current_version}",
      "compatible_version: #{compatible_version}"
    ]
  end

  defp timestamp(int, :format), do: int

  defp timestamp(int, :describe) do
    case DateTime.from_unix(int, :millisecond) do
      {:ok, t} -> t
      {:error, e} -> "Invalid (#{inspect(e)})"
    end
    |> DateTime.to_string()
  end
end
