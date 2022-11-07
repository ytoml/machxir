defmodule Machxir.MachO.LoadCommand.VersionMin do
  @moduledoc """
  Parsing LC_VERSION_MIN_MACOSX |
  		   LC_VERSION_MIN_IPHONEOS |
  		   LC_VERSION_MIN_WATCHOS |
  		   LC_VERSION_MIN_TVOS.
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
      "version: #{ByteCrawler.read_uint32(pid)}",
      "sdk:     #{ByteCrawler.read_uint32(pid)}"
    ]
  end
end
