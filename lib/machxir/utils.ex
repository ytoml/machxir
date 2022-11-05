defmodule Machxir.Utils do
  import Bitwise

  @doc """
  Get whether the bit of `int` at `shift`(0-indexed position) is 1 or not.
  """
  def is_pop_at(int, shift) do
    (int &&& 1 <<< shift) != 0
  end

  @doc """
  Generate one hot integers based on `int` and position set (`shift_amounts`)
  """
  def generate_one_hots(shift_amounts, int) do
    shift_amounts
    |> Enum.map(&is_pop_at(int, &1))
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
end
