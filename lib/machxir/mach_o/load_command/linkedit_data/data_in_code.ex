defmodule Machxir.MachO.LoadCommand.DataInCode do
  @moduledoc """
  Parsing LC_DATA_IN_CODE.
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

