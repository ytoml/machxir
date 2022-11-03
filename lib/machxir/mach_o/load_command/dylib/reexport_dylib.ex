defmodule Machxir.MachO.LoadCommand.ReexportDylib do
  @moduledoc """
  Parsing LC_REEXPORT_DYLIB.
  """

  alias Machxir.ByteCrawler

  @spec parse(pid, :describe | :format) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid, opt) do
  end
end

