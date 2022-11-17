defmodule Machxir.MachO.Header do
  alias Machxir.ByteCrawler

  @spec parse(binary, :mach | :mach64, any) :: {list, binary}
  def parse(<<header::binary-28, rest::binary>>, :mach, endianness),
    do: {parse_inner(header, endianness), rest}

  def parse(
        <<header::binary-28, reserved::binary-4, rest::binary>>,
        :mach64,
        endianness
      ) do
    if reserved != <<0, 0, 0, 0>>,
      do:
        IO.puts(
          :standard_error,
          "[WARN] Reserved bits of 64 bit mach-o header found dirty (#{inspect(reserved)})"
        )

    {parse_inner(header, endianness), rest}
  end

  defp parse_inner(header_bin, endianness) do
    {:ok, pid} = ByteCrawler.invoke(header_bin, endianness)

    Enum.map(
      [:magic, :cpu, :cpu_subtype, :filetype, :ncmds, :sizeofcmds, :flags],
      &{&1, ByteCrawler.read_uint32(pid)}
    )
  end
end
