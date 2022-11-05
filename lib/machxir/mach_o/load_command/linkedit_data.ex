defmodule Machxir.MachO.LoadCommand.LinkeditData do
  @moduledoc """
  linkedit_data_command
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
      "dataoff:  #{ByteCrawler.read_uint32(pid)}",
      "datasize: #{ByteCrawler.read_uint32(pid)}"
    ]
  end
end
