defmodule Machxir.MachO.LoadCommand.LinkerOptimizationHint do
  @moduledoc """
  Parsing LC_LINKER_OPTIMIZATION_HINT.
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

