defmodule Machxir.MachO.LoadCommand.Prepage do
  @moduledoc """
  Parsing LC_PREPAGE.
  """

  @spec parse(pid) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(_pid) do
    ["prepage command is for internal use"]
  end
end
