defmodule Machxir.ByteCrawler do
  alias Machxir.ByteCrawler.Server
  def invoke(bin, endianness) when is_binary(bin), do: Server.start_link({bin, endianness})
  def read_uint16(pid), do: GenServer.call(pid, {:read, 16})
  def read_uint32(pid), do: GenServer.call(pid, {:read, 32})
  def read_uint64(pid), do: GenServer.call(pid, {:read, 64})
  def read_rawbytes(pid, bytesize), do: GenServer.call(pid, {:read_raw, bytesize})
end
