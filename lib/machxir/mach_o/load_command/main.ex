defmodule Machxir.MachO.LoadCommand.Main do
  @moduledoc """
  Parsing LC_MAIN.
  Note that this stands for `entry_point_command` in `mach-o/loader.h`.
  """

  alias Machxir.ByteCrawler

  @spec parse(pid) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid) do
    [
      "entryoff:  #{ByteCrawler.read_uint64(pid)}",
      "stacksize: #{ByteCrawler.read_uint64(pid)}"
    ]
  end
end
