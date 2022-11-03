defmodule Machxir.MachO.LoadCommand.DylibCodeSignDrs do
  @moduledoc """
  Parsing LC_DYLIB_CODE_SIGN_DRS.
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

