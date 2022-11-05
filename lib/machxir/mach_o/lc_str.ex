defmodule Machxir.MachO.LcStr do
  alias Machxir.ByteCrawler
  alias Machxir.Utils

  @doc """
  Read string and annotate with offset.
  `pid` must be of the `ByteCrawler`server.
  """
  def get_annotated_string(_pid, addr, :mach),
    do: "Address (#{Utils.to_padded_hex32(addr)})"

  def get_annotated_string(pid, offset, :mach64),
    do: "#{ByteCrawler.take_all(pid)} (offset #{offset})"

  def get_annotated_string(_pid, _size, addr, :mach),
    do: "Address (#{Utils.to_padded_hex32(addr)})"

  def get_annotated_string(pid, bytesize, offset, :mach64),
    do: "#{ByteCrawler.read_rawbytes(pid, bytesize)} (offset #{offset})"
end
