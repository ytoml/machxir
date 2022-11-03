defmodule Machxir.MachO.LoadCommand do
  import Bitwise
  alias Machxir.ByteCrawler
  alias Machxir.MachO.LoadCommand
  @req_dyld 0x80000000

  @spec parse(any, any, atom, atom) :: [String.t() | list]
  @doc """
  `opt` must be `:format` or `:describe`
  """
  def parse(cmd, bin, endianness, opt = :format) do
    {:ok, pid} = ByteCrawler.invoke(bin, endianness)
    type = if (cmd &&& @req_dyld) == 0, do: nil, else: :req_dyld
    parse_inner(cmd, pid, type, opt)
  end

  defp parse_inner(cmd, pid, nil, opt) do
    # TODO: appropriate handling for situation where LC_LEQ_DYLD ones are passed.
    case cmd do
      0x01 -> LoadCommand.Segment.parse(pid, opt)
      0x02 -> LoadCommand.Symtab.parse(pid, opt)
      0x03 -> LoadCommand.Symseg.parse(pid, opt)
      0x04 -> LoadCommand.Thread.parse(pid, opt)
      0x05 -> LoadCommand.Unixthread.parse(pid, opt)
      0x06 -> LoadCommand.Loadfvmlib.parse(pid, opt)
      0x07 -> LoadCommand.Idfvmlib.parse(pid, opt)
      0x08 -> LoadCommand.Ident.parse(pid, opt)
      0x09 -> LoadCommand.Fvmfile.parse(pid, opt)
      0x0A -> LoadCommand.Prepage.parse(pid, opt)
      0x0B -> LoadCommand.Dysymtab.parse(pid, opt)
      0x0C -> LoadCommand.LoadDylib.parse(pid, opt)
      0x0D -> LoadCommand.IdDylib.parse(pid, opt)
      0x0E -> LoadCommand.LoadDylinker.parse(pid, opt)
      0x0F -> LoadCommand.IdDylinker.parse(pid, opt)
      0x10 -> LoadCommand.PreboundDylib.parse(pid, opt)
      0x11 -> LoadCommand.Routines.parse(pid, opt)
      0x12 -> LoadCommand.SubFramework.parse(pid, opt)
      0x13 -> LoadCommand.SubUmbrella.parse(pid, opt)
      0x14 -> LoadCommand.SubClient.parse(pid, opt)
      0x15 -> LoadCommand.SubLibrary.parse(pid, opt)
      0x16 -> LoadCommand.TwolevelHints.parse(pid, opt)
      0x17 -> LoadCommand.PrebindCksum.parse(pid, opt)
      0x18 -> "LoadWeekDylib is LC_REQ_DYLD"
      0x19 -> LoadCommand.Segment64.parse(pid, opt)
      0x1A -> LoadCommand.Routines64.parse(pid, opt)
      0x1B -> LoadCommand.FunctionStarts.parse(pid, opt)
      0x1C -> "Rpath is LC_REQ_DYLD"
      0x1D -> LoadCommand.CodeSignature.parse(pid, opt)
      0x1E -> LoadCommand.SegmentSplitInfo.parse(pid, opt)
      0x1F -> "ReexportDylib is LC_REQ_DYLD"
      0x20 -> LoadCommand.LazyLoadDylib.parse(pid, opt)
      0x21 -> LoadCommand.EncryptionInfo.parse(pid, opt)
      0x22 -> LoadCommand.DyldInfo.parse(pid, opt)
      0x23 -> "LoadUpwardDylib is LC_REQ_DYLD"
      0x24 -> LoadCommand.VersionMinMacosx.parse(pid, opt)
      0x25 -> LoadCommand.VersionMinIphoneos.parse(pid, opt)
      0x26 -> LoadCommand.FunctionStarts.parse(pid, opt)
      0x27 -> LoadCommand.DyldEnvironment.parse(pid, opt)
      0x28 -> "Main is LC_REQ_DYLD"
      0x29 -> LoadCommand.DataInCode.parse(pid, opt)
      0x2A -> LoadCommand.SourceVersion.parse(pid, opt)
      0x2B -> LoadCommand.DylibCodeSignDrs.parse(pid, opt)
      0x2C -> LoadCommand.EncryptionInfo64.parse(pid, opt)
      0x2D -> LoadCommand.LinkerOption.parse(pid, opt)
      0x2E -> LoadCommand.LinkerOptimizationHint.parse(pid, opt)
      0x2F -> LoadCommand.VersionMinTvos.parse(pid, opt)
      0x30 -> LoadCommand.VersionMinWatchos.parse(pid, opt)
      0x31 -> LoadCommand.Note.parse(pid, opt)
      0x32 -> LoadCommand.BuildVersion.parse(pid, opt)
      0x33 -> "DyldExportsTrie is LC_REQ_DYLD"
      0x34 -> "DyldChainedFixups is LC_REQ_DYLD"
      0x35 -> "FilesetEntry is LC_REQ_DYLD"
    end
  end

  defp parse_inner(cmd, pid, :req_dyld, opt) do
    case cmd &&& bnot(@req_dyld) do
      0x18 -> LoadCommand.LoadWeakDylib.parse(pid, opt)
      0x1C -> LoadCommand.Rpath.parse(pid, opt)
      0x1F -> LoadCommand.ReexportDylib.parse(pid, opt)
      0x22 -> LoadCommand.DyldInfoOnly.parse(pid, opt)
      0x23 -> LoadCommand.LoadUpwardDylib.parse(pid, opt)
      0x28 -> LoadCommand.Main.parse(pid, opt)
      0x33 -> LoadCommand.DyldExportsTrie.parse(pid, opt)
      0x34 -> LoadCommand.DyldChainedFixups.parse(pid, opt)
      0x35 -> LoadCommand.FilesetEntry.parse(pid, opt)
    end
  end
end
