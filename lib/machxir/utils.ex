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
end
