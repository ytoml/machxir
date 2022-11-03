defmodule Machxir.MachO.LoadCommand.VersionMinMacosx do
  @moduledoc """
  Parsing LC_VERSION_MIN_MACOSX.
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

