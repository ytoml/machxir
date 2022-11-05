defmodule Machxir.MachO.LoadCommand.Ident do
  @moduledoc """
  Parsing LC_IDENT.
  """

  alias Machxir.ByteCrawler

  @spec parse(pid) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid),
    do: [
      "(string): #{ByteCrawler.take_all(pid)}"
    ]
end
