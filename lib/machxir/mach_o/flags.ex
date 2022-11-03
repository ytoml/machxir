defmodule Machxir.MachO.Flags do
  import Bitwise
  alias Machxir.Utils

  def format(int), do: get_pops(int) |> Enum.map(&flag_string/1)
  def description(int), do: get_pops(int) |> Enum.map(&flag_description/1)

  defp get_pops(int) when is_integer(int) do
    0..31
    |> Enum.filter(&(not Enum.member?(28..30, &1)))
    |> Utils.generate_one_hots(int)
    |> Enum.map(&(1 <<< &1))
  end

  defp flag_string(flag) do
    case flag do
      0x00000001 -> "MH_NOUNDEFS"
      0x00000002 -> "MH_INCRLINK"
      0x00000004 -> "MH_DYLDLINK"
      0x00000008 -> "MH_BINDATLOAD"
      0x00000010 -> "MH_PREBOUND"
      0x00000020 -> "MH_SPLIT_SEGS"
      0x00000040 -> "MH_LAZY_INIT"
      0x00000080 -> "MH_TWOLEVEL"
      0x00000100 -> "MH_FORCE_FLAT"
      0x00000200 -> "MH_NOMULTIDEFS"
      0x00000400 -> "MH_NOFIXPREBINDING"
      0x00000800 -> "MH_PREBINDABLE"
      0x00001000 -> "MH_ALLMODSBOUND"
      0x00002000 -> "MH_SUBSECTIONS_VIA_SYMBOLS"
      0x00004000 -> "MH_CANONICAL"
      0x00008000 -> "MH_WEAK_DEFINES"
      0x00010000 -> "MH_BINDS_TO_WEAK"
      0x00020000 -> "MH_ALLOW_STACK_EXECUTION"
      0x00040000 -> "MH_ROOT_SAFE"
      0x00080000 -> "MH_SETUID_SAFE"
      0x00100000 -> "MH_NO_REEXPORTED_DYLIBS"
      0x00200000 -> "MH_PIE"
      0x00400000 -> "MH_DEAD_STRIPPABLE_DYLIB"
      0x00800000 -> "MH_HAS_TLV_DESCRIPTORS"
      0x01000000 -> "MH_NO_HEAP_EXECUTION"
      0x02000000 -> "MH_APP_EXTENSION_SAFE"
      0x04000000 -> "MH_NLIST_OUTOFSYNC_WITH_DYLDINFO"
      0x08000000 -> "MH_SIM_SUPPORT"
      0x80000000 -> "MH_DYLIB_IN_CACHE"
    end
  end

  defp flag_description(flag) do
    case flag do
      0x00000001 -> "No undefined references"
      0x00000002 -> "Output of an incremental link"
      0x00000004 -> "Input for the dynamic linker"
      0x00000008 -> "Undefined references are bound by the dynamic linker"
      0x00000010 -> "Dynamic undefined references are prebound"
      0x00000020 -> "Read-only and read-write segments are split"
      0x00000040 -> "The init routine is to be run lazily via catching memory faults"
      0x00000080 -> "Using two-level name space bindings"
      0x00000100 -> "Forcing all images to use flat name space bindings"
      0x00000200 -> "No multiple defintions of symbols in sub-images"
      0x00000400 -> "No notification to the prebinding agent"
      0x00000800 -> "Not prebound - Can have prebindings redone"
      0x00001000 -> "Binds to all two-level namespace modules of the dependent libraries"
      0x00002000 -> "Safe to divide up the sections for dead code stripping"
      0x00004000 -> "Canonicalized via the unprebind operation"
      0x00008000 -> "Contains external weak symbols"
      0x00010000 -> "Uses weak symbols"
      0x00020000 -> "Allows stack execution"
      0x00040000 -> "Safe for use in processes with uid zero"
      0x00080000 -> "Safe for use in processes when issetugid() is true"
      0x00100000 -> "No need to check for re-exported dependent dylibs"
      0x00200000 -> "Main executable is loaded at a random address"
      0x00400000 -> "Don't load if no symbols are being referenced from the dylib"
      0x00800000 -> "Contains a thread local variables section"
      0x01000000 -> "Forces a non-executable heap in the main executable"
      0x02000000 -> "Can be used in application extensions"
      0x04000000 -> "External symbols do not include all the symbols in the dyld info"
      0x08000000 -> "Allows simulator support"
      0x80000000 -> "Part of the dyld shared cache"
    end
  end
end
