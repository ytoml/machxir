defmodule Machxir.MachO.LoadCommand.PrebindCksum do
  @moduledoc """
  Parsing LC_PREBIND_CKSUM.
  """

  alias Machxir.ByteCrawler

  @spec parse(pid) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid) do
    ["cksum: #{ByteCrawler.read_uint32(pid)}"]
  end
end
