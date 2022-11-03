defmodule Machxir.MachO.Filetype do
  def format(int) do
    case int do
      0x01 -> "MH_OBJECT"
      0x02 -> "MH_EXECUTE"
      0x03 -> "MH_FVMLIB"
      0x04 -> "MH_CORE"
      0x05 -> "MH_PRELOAD"
      0x06 -> "MH_DYLIB"
      0x07 -> "MH_DYLINKER"
      0x08 -> "MH_BUNDLE"
      0x09 -> "MH_DYLIB_STUB"
      0x0A -> "MH_DSYM"
      0x0B -> "MH_KEXT_BUNDLE"
      0x0C -> "MH_FILESET"
      _ -> "Unknown"
    end
  end

  def description(int) do
    case int do
      0x01 -> "Relocatable object file"
      0x02 -> "Demand paged executable file"
      0x03 -> "Fixed VM shared library file"
      0x04 -> "Core file"
      0x05 -> "Preloaded executable file"
      0x06 -> "Dynamically bound shared library"
      0x07 -> "Dynamic link editor"
      0x08 -> "Dynamically bound bundle file"
      0x09 -> "Shared library stub for static linking only"
      0x0A -> "Companion file with only debug"
      0x0B -> "x86_64 kernel extension"
      0x0C -> "File set with a single linkedit"
      _ -> ""
    end
  end
end
