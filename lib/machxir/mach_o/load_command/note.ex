defmodule Machxir.MachO.LoadCommand.Note do
  @moduledoc """
  Parsing LC_NOTE.
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
    offset = ByteCrawler.read_uint64(pid) |> Utils.to_padded_hex64()
    size = ByteCrawler.read_uint64(pid) |> Utils.to_padded_hex64()

    [
      "data_owner: #{ByteCrawler.read_rawbytes(pid, 16)}",
      "offset:     #{offset}",
      "size:       #{size}"
    ]
  end
end
