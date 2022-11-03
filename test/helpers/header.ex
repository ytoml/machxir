defmodule Machxir.TestHelpers.Header do
  @expected 0x0A_0B_0C_0D
  @little_expected 0x0D_0C_0B_0A
  def generate(endianness), do: magic(endianness) <> base(endianness)
  def generate64(endianness), do: magic64(endianness) <> base(endianness) <> expected(endianness)

  def is_big_expected(int) when is_integer(int), do: @expected == int
  def is_little_expected(int) when is_integer(int), do: @little_expected == int

  defp magic(:big), do: <<0xFEEDFACE::unsigned-big-32>>
  defp magic(:little), do: <<0xCEFAEDFE::unsigned-big-32>>
  defp magic64(:big), do: <<0xFEEDFACF::unsigned-big-32>>
  defp magic64(:little), do: <<0xCFFAEDFE::unsigned-big-32>>
  defp expected(:big), do: <<@expected::unsigned-big-32>>
  defp expected(:little), do: <<@expected::unsigned-little-32>>

  defp base(endianness) do
    cpu = cpu_subtype = filetype = ncmds = sizeofcmds = flags = expected(endianness)
    cpu <> cpu_subtype <> filetype <> ncmds <> sizeofcmds <> flags
  end
end
