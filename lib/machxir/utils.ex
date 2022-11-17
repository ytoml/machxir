defmodule Machxir.Utils do
  import Bitwise

  @doc """
  Generate one hot integers based on `int` and position set (`shift_amounts`)
  """
  def generate_one_hots(shift_amounts, int) do
    shift_amounts
    |> Enum.map(&(1 <<< &1))
    |> Enum.filter(&((&1 &&& int) != 0))
  end

  @doc """
  Check the binary and put warning if neither zero-filled nor empty.
  """
  def check_zero_or_empty(<<>>, _), do: nil

  def check_zero_or_empty(bin, location) when is_binary(bin) do
    warn = String.graphemes(bin) |> Enum.any?(fn b -> b != <<0>> end)

    if warn do
      IO.puts(:standard_error, "[WARN] #{location}: Invalid padding found (#{inspect(bin)})")
    end
  end

  @doc """
  Make hexadecimal string padding up to 16.
  """
  def to_padded_hex64(int),
    do: "0x" <> (int |> Integer.to_string(16) |> String.pad_leading(16, "0"))

  @doc """
  Make hexadecimal string padding up to 8.
  """
  def to_padded_hex32(int),
    do: "0x" <> (int |> Integer.to_string(16) |> String.pad_leading(8, "0"))
end
