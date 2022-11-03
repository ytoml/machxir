defmodule Machxir.MachO.LoadCommand.VersionMinTvos do
  @moduledoc """
  Parsing LC_VERSION_MIN_TVOS.
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

