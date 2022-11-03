defmodule Machxir.MachO.LoadCommand.LoadDylib do
  @moduledoc """
  Parsing LC_LOAD_DYLIB.
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

