defmodule Machxir.MachO.LoadCommand do
  import Bitwise
  alias Machxir.ByteCrawler
  alias Machxir.MachO.LoadCommand
  @req_dyld 0x80000000

  @spec parse(integer, any, binary, any, :mach | :mach64, :describe | :format) :: [
          String.t() | list
        ]
  @doc """
  `body` must be the content of command **excluding** `cmd` and `cmdsize`.
  """
  def parse(cmd, cmdsize, body, endianness, arch, opt \\ :format) when is_binary(body) do
    {:ok, pid} = ByteCrawler.invoke(body, endianness)
    type = if (cmd &&& @req_dyld) == 0, do: nil, else: :req_dyld

    [
      "cmd:     #{format(cmd, type)}",
      "cmdsize: #{cmdsize}",
      parse_inner(cmd, cmdsize, pid, arch, type, opt)
    ]
  end

  defp parse_inner(cmd, _cmdsize, pid, arch, nil, opt) do
    # TODO: appropriate handling for situation where LC_LEQ_DYLD ones are passed.
    case cmd do
      0x01 -> LoadCommand.Segment.parse(pid, opt)
      0x02 -> LoadCommand.Symtab.parse(pid, opt)
      0x03 -> LoadCommand.Symseg.parse(pid, opt)
      0x04 -> LoadCommand.Thread.parse(pid, opt)
      0x05 -> LoadCommand.Thread.Unix.parse(pid, opt)
      0x06 -> LoadCommand.Fvmlib.parse(pid, arch)
      0x07 -> LoadCommand.Fvmlib.parse(pid, arch)
      0x08 -> LoadCommand.Ident.parse(pid)
      0x09 -> LoadCommand.Fvmfile.parse(pid, arch)
      0x0A -> LoadCommand.Prepage.parse(pid, opt)
      0x0B -> LoadCommand.Dysymtab.parse(pid)
      0x0C -> LoadCommand.Dylib.parse(pid, arch, opt)
      0x0D -> LoadCommand.Dylib.parse(pid, arch, opt)
      0x0E -> LoadCommand.Dylinker.parse(pid, arch)
      0x0F -> LoadCommand.Dylinker.parse(pid, arch)
      0x10 -> LoadCommand.PreboundDylib.parse(pid, opt)
      0x11 -> LoadCommand.Routines.parse(pid, opt)
      0x12 -> LoadCommand.SubFramework.parse(pid, opt)
      0x13 -> LoadCommand.SubUmbrella.parse(pid, opt)
      0x14 -> LoadCommand.SubClient.parse(pid, opt)
      0x15 -> LoadCommand.SubLibrary.parse(pid, opt)
      0x16 -> LoadCommand.TwolevelHints.parse(pid, opt)
      0x17 -> LoadCommand.PrebindCksum.parse(pid, opt)
      0x19 -> LoadCommand.Segment64.parse(pid, opt)
      0x1A -> LoadCommand.Routines64.parse(pid, opt)
      0x1B -> LoadCommand.Uuid.parse(pid, opt)
      0x1D -> LoadCommand.LinkeditData.parse(pid)
      0x1E -> LoadCommand.LinkeditData.parse(pid)
      0x20 -> LoadCommand.Dylib.parse(pid, arch, opt)
      0x21 -> LoadCommand.EncryptionInfo.parse(pid)
      0x22 -> LoadCommand.DyldInfo.parse(pid, opt)
      0x24 -> LoadCommand.VersionMin.Macosx.parse(pid, opt)
      0x25 -> LoadCommand.VersionMin.Iphoneos.parse(pid, opt)
      0x26 -> LoadCommand.LinkeditData.parse(pid)
      0x27 -> LoadCommand.Dylinker.parse(pid, arch)
      0x29 -> LoadCommand.LinkeditData.parse(pid)
      0x2A -> LoadCommand.SourceVersion.parse(pid, opt)
      0x2B -> LoadCommand.LinkeditData.parse(pid)
      0x2C -> LoadCommand.EncryptionInfo64.parse(pid)
      0x2D -> LoadCommand.LinkerOption.parse(pid, opt)
      0x2E -> LoadCommand.LinkeditData.parse(pid)
      0x2F -> LoadCommand.VersionMin.Tvos.parse(pid, opt)
      0x30 -> LoadCommand.VersionMin.Watchos.parse(pid, opt)
      0x31 -> LoadCommand.Note.parse(pid, opt)
      0x32 -> LoadCommand.BuildVersion.parse(pid, opt)
      _ -> []
    end
  end

  def format(cmd, nil) do
    case cmd do
      0x01 -> "LC_SEGMENT"
      0x02 -> "LC_SYMTAB"
      0x03 -> "LC_SYMSEG"
      0x04 -> "LC_THREAD"
      0x05 -> "LC_UNIXTHREAD"
      0x06 -> "LC_LOADFVMLIB"
      0x07 -> "LC_IDFVMLIB"
      0x08 -> "LC_IDENT"
      0x09 -> "LC_FVMFILE"
      0x0A -> "LC_PREPAGE"
      0x0B -> "LC_DYSYMTAB"
      0x0C -> "LC_LOAD_DYLIB"
      0x0D -> "LC_ID_DYLIB"
      0x0E -> "LC_LOAD_DYLINKER"
      0x0F -> "LC_ID_DYLINKER"
      0x10 -> "LC_PREBOUND_DYLIB"
      0x11 -> "LC_ROUTINES"
      0x12 -> "LC_SUB_FRAMEWORK"
      0x13 -> "LC_SUB_UMBRELLA"
      0x14 -> "LC_SUB_CLIENT"
      0x15 -> "LC_SUB_LIBRARY"
      0x16 -> "LC_TWOLEVEL_HINTS"
      0x17 -> "LC_PREBIND_CKSUM"
      0x19 -> "LC_SEGMENT_64"
      0x1A -> "LC_ROUTINES_64"
      0x1B -> "LC_UUID"
      0x1D -> "LC_CODE_SIGNATURE"
      0x1E -> "LC_SEGMENT_SPLIT_INFO"
      0x20 -> "LC_LAZY_LOAD_DYLIB"
      0x21 -> "LC_ENCRYPTION_INFO"
      0x22 -> "LC_DYLD_INFO"
      0x24 -> "LC_VERSION_MIN_MACOSX"
      0x25 -> "LC_VERSION_MIN_IPHONEOS"
      0x26 -> "LC_FUNCTION_STARTS"
      0x27 -> "LC_DYLID_ENVIRONMENT"
      0x29 -> "LC_DATA_IN_CODE"
      0x2A -> "LC_SOURCE_VERSION"
      0x2B -> "LC_DYLIB_CODE_SIGN_DRS"
      0x2C -> "LC_ENCRYPTION_INFO_64"
      0x2D -> "LC_LINKER_OPTION"
      0x2E -> "LC_LINKER_OPTIMIZATION_HINT"
      0x2F -> "LC_VERSION_MIN_TVOS"
      0x30 -> "LC_VERSION_MIN_WATCHOS"
      0x31 -> "LC_NOTE"
      0x32 -> "LC_BUILD_VERSION"
      _ -> "INVALID (#{cmd})"
    end
  end

  defp parse_inner(cmd, _cmdsize, pid, arch, :req_dyld, opt) do
    case cmd &&& bnot(@req_dyld) do
      0x18 -> LoadCommand.Dylib.parse(pid, arch, opt)
      0x1C -> LoadCommand.Rpath.parse(pid, opt)
      0x1F -> LoadCommand.Dylib.parse(pid, arch, opt)
      0x22 -> LoadCommand.DyldInfo.Only.parse(pid, opt)
      0x23 -> LoadCommand.LoadUpwardDylib.parse(pid, opt)
      0x28 -> LoadCommand.Main.parse(pid, opt)
      0x33 -> LoadCommand.LinkeditData.parse(pid)
      0x34 -> LoadCommand.LinkeditData.parse(pid)
      0x35 -> LoadCommand.FilesetEntry.parse(pid, arch)
      _ -> []
    end
  end

  def format(cmd, :req_dyld) do
    case cmd do
      0x18 -> "LC_WEAK_DYLIB"
      0x1C -> "LC_RPATH"
      0x1F -> "LC_REEXPORT_DYLIB"
      0x22 -> "LC_DYLD_INFO_ONLY"
      0x23 -> "LC_LOAD_UPWARD_DYLIB"
      0x28 -> "LC_MAIN"
      0x33 -> "LC_DYLID_EXPORTS_TRIE"
      0x34 -> "LC_DYLID_CHAINED_FIXUPS"
      0x35 -> "FILESET_ENTRY"
      _ -> "INVALID (#{cmd} found for LC_REQ_DYLD)"
    end
  end

  def format(cmd, nil) do
    case cmd do
      0x01 -> "LC_SEGMENT"
      0x02 -> "LC_SYMTAB"
      0x03 -> "LC_SYMSEG"
      0x04 -> "LC_THREAD"
      0x05 -> "LC_UNIXTHREAD"
      0x06 -> "LC_LOADFVMLIB"
      0x07 -> "LC_IDFVMLIB"
      0x08 -> "LC_IDENT"
      0x09 -> "LC_FVMFILE"
      0x0A -> "LC_PREPAGE"
      0x0B -> "LC_DYSYMTAB"
      0x0C -> "LC_LOAD_DYLIB"
      0x0D -> "LC_ID_DYLIB"
      0x0E -> "LC_LOAD_DYLINKER"
      0x0F -> "LC_ID_DYLINKER"
      0x10 -> "LC_PREBOUND_DYLIB"
      0x11 -> "LC_ROUTINES"
      0x12 -> "LC_SUB_FRAMEWORK"
      0x13 -> "LC_SUB_UMBRELLA"
      0x14 -> "LC_SUB_CLIENT"
      0x15 -> "LC_SUB_LIBRARY"
      0x16 -> "LC_TWOLEVEL_HINTS"
      0x17 -> "LC_PREBIND_CKSUM"
      0x19 -> "LC_SEGMENT_64"
      0x1A -> "LC_ROUTINES_64"
      0x1B -> "LC_UUID"
      0x1D -> "LC_CODE_SIGNATURE"
      0x1E -> "LC_SEGMENT_SPLIT_INFO"
      0x20 -> "LC_LAZY_LOAD_DYLIB"
      0x21 -> "LC_ENCRYPTION_INFO"
      0x22 -> "LC_DYLD_INFO"
      0x24 -> "LC_VERSION_MIN_MACOSX"
      0x25 -> "LC_VERSION_MIN_IPHONEOS"
      0x26 -> "LC_FUNCTION_STARTS"
      0x27 -> "LC_DYLID_ENVIRONMENT"
      0x29 -> "LC_DATA_IN_CODE"
      0x2A -> "LC_SOURCE_VERSION"
      0x2B -> "LC_DYLIB_CODE_SIGN_DRS"
      0x2C -> "LC_ENCRYPTION_INFO_64"
      0x2D -> "LC_LINKER_OPTION"
      0x2E -> "LC_LINKER_OPTIMIZATION_HINT"
      0x2F -> "LC_VERSION_MIN_TVOS"
      0x30 -> "LC_VERSION_MIN_WATCHOS"
      0x31 -> "LC_NOTE"
      0x32 -> "LC_BUILD_VERSION"
      _ -> "INVALID (#{cmd})"
    end
  end
end
