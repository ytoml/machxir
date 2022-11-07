defmodule Machxir.MachO.LoadCommand.Symseg do
  @moduledoc """
  Parsing LC_SYMSEG.
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
    offset = ByteCrawler.read_int32(pid) |> Utils.to_padded_hex32()
    size = ByteCrawler.read_int32(pid) |> Utils.to_padded_hex32()

    [
      "offset: #{offset}",
      "size: #{size}"
    ]
  end
end
