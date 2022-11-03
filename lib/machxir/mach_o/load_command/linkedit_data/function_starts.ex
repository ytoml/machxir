defmodule Machxir.MachO.LoadCommand.FunctionStarts do
  @moduledoc """
  Parsing LC_FUNCTION_STARTS.
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

