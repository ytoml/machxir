defmodule Machxir do
  alias Machxir.ByteCrawler
  alias Machxir.MachO.{Cpu, Header, LoadCommand}

  def parse(<<0xFEEDFACE::unsigned-little-integer-32, _::binary>> = binary, mode),
    do: mach_o_file(binary, :mach, :little, mode)

  def parse(<<0xFEEDFACF::unsigned-little-integer-32, _::binary>> = binary, mode),
    do: mach_o_file(binary, :mach64, :little, mode)

  def parse(<<0xCEFAEDFE::unsigned-little-integer-32, _::binary>> = binary, mode),
    do: mach_o_file(binary, :mach, :big, mode)

  def parse(<<0xCFFAEDFE::unsigned-little-integer-32, _::binary>> = binary, mode),
    do: mach_o_file(binary, :mach64, :big, mode)

  def parse(<<0x64796C64::unsigned-little-integer-32, _::binary>> = binary, mode),
    do: cache_file(binary, mode)

  def parse(<<0xCAFEBABE::unsigned-little-integer-32, _::binary>> = binary, mode),
    do: fat_file(binary, mode)

  def parse(<<invalid_sig::unsigned-little-integer-32, _::binary>>, _),
    do: IO.puts(:standard_error, "Invalid signature (#{Integer.to_string(invalid_sig, 16)})")

  defp mach_o_file(binary, arch, endianness, mode) do
    {header, rest} = Header.parse(binary, arch, endianness)
    cpu = Cpu.parse(header[:cpu], header[:cpu_subtype])
    ldcmd_size = header[:sizeofcmds]
    <<load_commands::binary-size(ldcmd_size), _segments::binary>> = rest

    {:ok, pid} = ByteCrawler.invoke(load_commands, endianness)

    ldcmds_parsed =
      1..header[:ncmds]
      |> Stream.map(fn _ ->
        cmd = ByteCrawler.read_uint32(pid)
        cmdsize = ByteCrawler.read_uint32(pid)
        content = ByteCrawler.read_rawbytes(pid, cmdsize - 8)
        {cmd, cmdsize, content}
      end)
      |> Stream.map(fn {cmd, cmdsize, content} ->
        Task.async(fn -> LoadCommand.parse(cmd, cmdsize, content, endianness, arch, mode) end)
      end)
      |> Enum.map(&Task.await/1)
      |> Enum.with_index(1)
      |> Enum.map(fn {lcmd, i} ->
        [
          "Load Command #{i}",
          lcmd
        ]
      end)
      |> Enum.concat()

    [
      "Header",
      [
        "CPU",
        cpu,
        "sizeofcmds: #{header[:sizeofcmds]}",
        "ncmds:      #{header[:ncmds]}"
      ]
      | ldcmds_parsed
    ]
  end

  defp cache_file(_binary, _mode), do: IO.puts("Cache file parse is unimplemented!")
  defp fat_file(_binary, _mode), do: IO.puts("Fat file parse is unimplemented!")
end
