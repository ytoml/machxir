defmodule Machxir.ByteCrawler.Server do
  use GenServer

  @moduledoc """
  Server that offers byte stream reader functionality.
  Only UInt read is sufficient for binary parsing, this server only provide
  methods on UInt.
  """

  def start_link({bin, endianness}) do
    GenServer.start_link(__MODULE__, {bin, endianness})
  end

  def init({bin, endianness}) do
    {:ok, {bin, endianness}}
  end

  def handle_call({:read, _size}, _from, {<<>>, endianness}) do
    {:stop, :normal, {<<>>, endianness}}
  end

  def handle_call({:read, size}, _from, {bin, endianness}) do
    IO.inspect(size)
    IO.inspect(bin)
    IO.inspect(endianness)
    {got, rest} = read(bin, size, endianness)
    {:reply, got, {rest, endianness}}
  end

  def handle_call({:read_raw, bytesize}, _from, {bin, endianness}) do
    <<got::binary-size(bytesize), rest::binary>> = bin
    {:reply, got, {rest, endianness}}
  end

  defp read(bin, size, :little), do: read_little(bin, size)
  defp read(bin, size, :big), do: read_big(bin, size)

  defp read_little(bin, size) do
    <<int::unsigned-little-size(size), rest::binary>> = bin
    {int, rest}
  end

  defp read_big(bin, size) do
    <<int::unsigned-big-size(size), rest::binary>> = bin
    {int, rest}
  end
end
