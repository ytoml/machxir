defmodule Machxir.MachO.LoadCommand.Uuid do
  @moduledoc """
  Parsing LC_UUID.
  """

  alias Machxir.ByteCrawler

  @spec parse(pid) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid) do
    uuid =
      [4, 2, 2, 2, 6]
      |> Enum.map(fn bytesize ->
        ByteCrawler.read_rawbytes(pid, bytesize)
        |> :binary.bin_to_list()
        |> Enum.map(&Integer.to_string(&1, 16))
        |> Enum.join("")
      end)
      |> Enum.join("-")

    [
      "uuid: #{uuid}"
    ]
  end
end
