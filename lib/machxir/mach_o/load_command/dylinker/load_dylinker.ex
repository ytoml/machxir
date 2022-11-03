defmodule Machxir.MachO.LoadCommand.LoadDylinker do
  @moduledoc """
  Parsing LC_LOAD_DYLINKER.
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
