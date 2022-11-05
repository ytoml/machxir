defmodule Machxir.MachO.LoadCommand.EncryptionInfo do
  @moduledoc """
  Parsing LC_ENCRYPTION_INFO.
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
      "cryptoff:  #{ByteCrawler.read_uint32(pid)}",
      "cryptsize: #{ByteCrawler.read_uint32(pid)}",
      "cryptsize: #{ByteCrawler.read_uint32(pid)}"
    ]
  end
end
