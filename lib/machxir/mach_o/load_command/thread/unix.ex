defmodule Machxir.MachO.LoadCommand.Thread.Unix do
  @moduledoc """
  Parsing LC_UNIXTHREAD.
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
