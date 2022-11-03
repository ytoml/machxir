defmodule ByteCrawlerTest do
  use ExUnit.Case
  alias Machxir.ByteCrawler
  doctest Machxir.ByteCrawler

  test "byte crawling" do
    size = 8 * 14
    testbin = <<0x0A_0B_0C_0D_0E_0F_10_11_12_13_14_15_16_17::size(size)>>
    {:ok, b_pid} = ByteCrawler.invoke(testbin, :big)
    assert 0x0A_0B == ByteCrawler.read_uint16(b_pid)
    assert 0x0C_0D_0E_0F == ByteCrawler.read_uint32(b_pid)
    assert 0x10_11_12_13_14_15_16_17 == ByteCrawler.read_uint64(b_pid)
    catch_exit(ByteCrawler.read_uint64(b_pid))

    {:ok, l_pid} = ByteCrawler.invoke(testbin, :little)
    assert 0x0B_0A == ByteCrawler.read_uint16(l_pid)
    assert 0x0F_0E_0D_0C == ByteCrawler.read_uint32(l_pid)
    assert 0x17_16_15_14_13_12_11_10 == ByteCrawler.read_uint64(l_pid)
    catch_exit(ByteCrawler.read_uint64(l_pid))

    {:ok, r_pid} = ByteCrawler.invoke(testbin, :little)

    assert <<0x0A_0B_0C_0D_0E_0F_10_11_12_13_14_15::size(8 * 12)>> ==
             ByteCrawler.read_rawbytes(r_pid, 12)

    assert 0x17_16 == ByteCrawler.read_uint16(r_pid)
    catch_exit(ByteCrawler.read_uint64(r_pid))
  end
end
