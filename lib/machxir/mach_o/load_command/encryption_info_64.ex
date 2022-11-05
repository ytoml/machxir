defmodule Machxir.MachO.LoadCommand.EncryptionInfo64 do
  @moduledoc """
  Parsing LC_ENCRYPTION_INFO_64.
  """

  alias Machxir.ByteCrawler
  alias Machxir.Utils

  @spec parse(pid) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid) do
    ret = [
      "cryptoff:  #{ByteCrawler.read_uint32(pid)}",
      "cryptsize: #{ByteCrawler.read_uint32(pid)}",
      "cryptsize: #{ByteCrawler.read_uint32(pid)}"
    ]

    ByteCrawler.read_rawbytes(pid, 4) |> Utils.check_zero_or_empty(__MODULE__)
    ret
  end
end
