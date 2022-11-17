defmodule Machxir.MachO.SectionFlags do
  alias Machxir.Utils

  @spec parse(integer, :describe | :format) :: [String.t() | list]
  def parse(int, :format), do: format(int)
  def parse(int, :describe), do: description(int)

  defp format(int) do
    [
      "type:       #{type(int)}",
      "attributes: #{attributes(int)}"
    ]
  end

  defp description(int), do: format(int)

  defp type(int) do
    case int do
      0x00 -> "S_REGULAR"
      0x01 -> "S_ZEROFILL"
      0x02 -> "S_CSTRING_LITERALS"
      0x03 -> "S_4BYTE_LITERALS"
      0x04 -> "S_8BYTE_LITERALS"
      0x05 -> "S_LITERAL_POINTERS"
      0x06 -> "S_NON_LAZY_SYMBOL_POINTERS"
      0x07 -> "S_LAZY_SYMBOL_POINTERS"
      0x08 -> "S_SYMBOL_STUBS"
      0x09 -> "S_MOD_INIT_FUNC_POINTERS"
      0x0A -> "S_MOD_TERM_FUNC_POINTERS"
      0x0B -> "S_COALESCED"
      0x0C -> "S_GB_ZEROFILL"
      0x0D -> "S_INTERPOSING"
      0x0E -> "S_16BYTE_LITERALS"
      0x0F -> "S_DTRACE_DOF"
      0x10 -> "S_LAZY_DYLIB_SYMBOL_POINTERS"
      0x11 -> "S_THREAD_LOCAL_REGULAR"
      0x12 -> "S_THREAD_LOCAL_ZEROFILL"
      0x13 -> "S_THREAD_LOCAL_VARIABLES"
      0x14 -> "S_THREAD_LOCAL_VARIABLE_POINTERS"
      0x15 -> "S_THREAD_LOCAL_INIT_FUNCTION_POINTERS"
      0x16 -> "S_INIT_FUNC_OFFSETS"
      _ -> "Unknown (#{int})"
    end
  end

  defp attributes(int) do
    (Enum.to_list(8..10) ++ Enum.to_list(25..31))
    |> Utils.generate_one_hots(int)
    |> Enum.map(&flag_string/1)
    |> Enum.join(",")
  end

  defp flag_string(int) do
    case int do
      0x80000000 -> "S_ATTR_PURE_INSTRUCTIONS"
      0x40000000 -> "S_ATTR_NO_TOC"
      0x20000000 -> "S_ATTR_STRIP_STATIC_SYMS"
      0x10000000 -> "S_ATTR_NO_DEAD_STRIP"
      0x08000000 -> "S_ATTR_LIVE_SUPPORT"
      0x04000000 -> "S_ATTR_SELF_MODIFYING_CODE"
      0x02000000 -> "S_ATTR_DEBUG"
      0x00000400 -> "S_ATTR_SOME_INSTRUCTIONS"
      0x00000200 -> "S_ATTR_EXT_RELOC"
      0x00000100 -> "S_ATTR_LOC_RELOC"
      _ -> "Unknown"
    end
  end
end
