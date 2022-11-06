defmodule Machxir.ByteCrawler do
  alias Machxir.ByteCrawler.Server
  def invoke(bin, endianness) when is_binary(bin), do: Server.start_link({bin, endianness})
  def read_uint16(pid), do: GenServer.call(pid, {:read, 16, :unsigned})
  def read_int16(pid), do: GenServer.call(pid, {:read, 16, :signed})
  def read_uint32(pid), do: GenServer.call(pid, {:read, 32, :unsigned})
  def read_int32(pid), do: GenServer.call(pid, {:read, 32, :signed})
  def read_uint64(pid), do: GenServer.call(pid, {:read, 64, :unsigned})
  def read_int64(pid), do: GenServer.call(pid, {:read, 64, :signed})
  def read_rawbytes(pid, bytesize), do: GenServer.call(pid, {:read_raw, bytesize})
  def take_all(pid), do: GenServer.call(pid, {:take_all})
end
