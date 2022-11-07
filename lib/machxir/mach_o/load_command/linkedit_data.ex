defmodule Machxir.MachO.LoadCommand.LinkeditData do
  @moduledoc """
  Parsing LC_CODE_SIGNATURE | LC_SEGMENT_SPLIT_INFO |
  		   LC_FUNCTION_STARTS | LC_DATA_IN_CODE |
  		   LC_DYLIB_CODE_SIGN_DRS |
  		   LC_LINKER_OPTIMIZATION_HINT |
  		   LC_DYLD_EXPORTS_TRIE |
  		   LC_DYLD_CHAINED_FIXUPS.
  """

  alias Machxir.ByteCrawler

  @spec parse(pid) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid) do
    [
      "dataoff:  #{ByteCrawler.read_uint32(pid)}",
      "datasize: #{ByteCrawler.read_uint32(pid)}"
    ]
  end
end
