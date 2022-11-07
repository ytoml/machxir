defmodule Machxir.MachO.LoadCommand.DyldInfo do
  @moduledoc """
  Parsing LC_DYLD_INFO | LC_DYLD_INFO_ONLY
  """

  alias Machxir.ByteCrawler

  @spec parse(pid, :describe | :format) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid, _opt) do
    [
      "rebase_off:     #{ByteCrawler.read_uint32(pid)}",
      "rebase_size:    #{ByteCrawler.read_uint32(pid)}",
      "bind_off:       #{ByteCrawler.read_uint32(pid)}",
      "bind_size:      #{ByteCrawler.read_uint32(pid)}",
      "weak_bind_off:  #{ByteCrawler.read_uint32(pid)}",
      "weak_bind_size: #{ByteCrawler.read_uint32(pid)}",
      "lazy_bind_off:  #{ByteCrawler.read_uint32(pid)}",
      "lazy_bind_size: #{ByteCrawler.read_uint32(pid)}",
      "export_off:     #{ByteCrawler.read_uint32(pid)}",
      "export_size:    #{ByteCrawler.read_uint32(pid)}"
    ]
  end
end
