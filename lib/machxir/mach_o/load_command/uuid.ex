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
      ByteCrawler.read_rawbytes(pid, 16)
      |> :binary.bin_to_list()
      |> Enum.map(&Integer.to_string/1)
      |> Enum.join("")

    [
      "uuid: #{uuid}"
    ]
  end
end
