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

  def handle_call({:read, _size, _sign}, _from, {<<>>, endianness}) do
    {:stop, :normal, {<<>>, endianness}}
  end

  def handle_call({:read, size, sign}, _from, {bin, endianness}) do
    # IO.inspect(size)
    # IO.inspect(bin)
    # IO.inspect(endianness)
    {got, rest} = read(bin, size, sign, endianness)
    {:reply, got, {rest, endianness}}
  end

  def handle_call({:read_raw, bytesize}, _from, {bin, endianness}) do
    <<got::binary-size(bytesize), rest::binary>> = bin
    {:reply, got, {rest, endianness}}
  end

  def handle_call({:take_all}, _from, {bin, endianness}) do
    {:reply, bin, {<<>>, endianness}}
  end

  defp read(bin, size, :signed, :little), do: read_little_signed(bin, size)
  defp read(bin, size, :unsigned, :little), do: read_little_unsigned(bin, size)
  defp read(bin, size, :signed, :big), do: read_big_signed(bin, size)
  defp read(bin, size, :unsigned, :big), do: read_big_unsigned(bin, size)

  defp read_little_unsigned(bin, size) do
    <<int::unsigned-little-size(size), rest::binary>> = bin
    {int, rest}
  end

  defp read_little_signed(bin, size) do
    <<int::signed-little-size(size), rest::binary>> = bin
    {int, rest}
  end

  defp read_big_unsigned(bin, size) do
    <<int::unsigned-big-size(size), rest::binary>> = bin
    {int, rest}
  end

  defp read_big_signed(bin, size) do
    <<int::signed-big-size(size), rest::binary>> = bin
    {int, rest}
  end
end
