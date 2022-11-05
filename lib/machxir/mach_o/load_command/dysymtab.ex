defmodule Machxir.MachO.LoadCommand.Dysymtab do
  @moduledoc """
  Parsing LC_DYSYMTAB.
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
      "ilocalsym:      #{ByteCrawler.read_uint32(pid)}",
      "nlocalsym:      #{ByteCrawler.read_uint32(pid)}",
      "iextdefsym:     #{ByteCrawler.read_uint32(pid)}",
      "nextdefsym:     #{ByteCrawler.read_uint32(pid)}",
      "iundefsym:      #{ByteCrawler.read_uint32(pid)}",
      "nundefsym:      #{ByteCrawler.read_uint32(pid)}",
      "tocoff:         #{ByteCrawler.read_uint32(pid)}",
      "ntoc:           #{ByteCrawler.read_uint32(pid)}",
      "modtaboff:      #{ByteCrawler.read_uint32(pid)}",
      "nmodtab:        #{ByteCrawler.read_uint32(pid)}",
      "extrefsymoff:   #{ByteCrawler.read_uint32(pid)}",
      "nextrefsyms:    #{ByteCrawler.read_uint32(pid)}",
      "indirectsymoff: #{ByteCrawler.read_uint32(pid)}",
      "nindirectsyms:  #{ByteCrawler.read_uint32(pid)}",
      "extreloff:      #{ByteCrawler.read_uint32(pid)}",
      "nextrel:        #{ByteCrawler.read_uint32(pid)}",
      "locreloff:      #{ByteCrawler.read_uint32(pid)}",
      "nlocrel:        #{ByteCrawler.read_uint32(pid)}"
    ]
  end
end
