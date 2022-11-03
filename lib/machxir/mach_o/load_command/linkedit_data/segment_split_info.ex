defmodule Machxir.MachO.LoadCommand.SegmentSplitInfo do
  @moduledoc """
  Parsing LC_SEGMENT_SPLIT_INFO.
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

