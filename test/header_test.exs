defmodule HeaderTest do
  use ExUnit.Case
  alias Machxir.MachO.Header
  alias Machxir.TestHelpers.Header, as: TH

  test "parse header" do
    parse(:march_o, :big) |> assert_header(&TH.is_big_expected/1)
    parse(:march_o64, :big) |> assert_header(&TH.is_big_expected/1)
    parse(:march_o, :little) |> assert_header(&TH.is_little_expected/1)
    parse(:march_o64, :little) |> assert_header(&TH.is_little_expected/1)
  end

  defp parse(:march_o, endianness),
    do: TH.generate(endianness) |> Header.parse(:march_o, endianness) |> elem(0)

  defp parse(:march_o64, endianness),
    do: TH.generate64(endianness) |> Header.parse(:march_o64, endianness) |> elem(0)

  defp assert_header(keylist, assertfunc) do
    assertfunc.(keylist[:magic])
    assertfunc.(keylist[:cpu])
    assertfunc.(keylist[:cpu_subtype])
    assertfunc.(keylist[:filetype])
    assertfunc.(keylist[:ncmds])
    assertfunc.(keylist[:sizeofcmds])
    assertfunc.(keylist[:flags])
  end
end
