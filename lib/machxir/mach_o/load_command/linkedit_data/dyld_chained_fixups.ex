defmodule Machxir.MachO.LoadCommand.DyldChainedFixups do
  @moduledoc """
  Parsing LC_DYLD_CHAINED_FIXUPS.
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

