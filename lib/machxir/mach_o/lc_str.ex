defmodule Machxir.MachO.LcStr do
  alias Machxir.ByteCrawler
  alias Machxir.Utils

  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def read_string(_pid, :mach), do: "Not supported"
  def read_string(pid, :mach64), do: ByteCrawler.take_all(pid)
  def read_string(_pid, _size, :mach), do: "Not supported"
  def read_string(pid, bytesize, :mach64), do: ByteCrawler.read_rawbytes(pid, bytesize)
end
