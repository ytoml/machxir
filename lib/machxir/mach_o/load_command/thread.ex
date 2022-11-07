defmodule Machxir.MachO.LoadCommand.Thread do
  @moduledoc """
  Parsing LC_THREAD | LC_UNIXTHREAD.
  """

  alias Machxir.ByteCrawler

  @spec parse(pid, integer()) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid, cmdsize) do
    case cmdsize do
      s when s < 8 ->
        ["Invalid cmdsize found (#{s})"]

      s when s == 8 ->
        ["No flavor attatched"]

      _ ->
        # ignore thread_state
        [
          "flavor: #{ByteCrawler.read_int32(pid)}",
          "count:  #{ByteCrawler.read_int32(pid)}"
        ]
    end
  end
end
