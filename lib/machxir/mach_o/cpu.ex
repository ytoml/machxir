defmodule Machxir.MachO.Cpu do
  import Bitwise
  @abi64 0x01000000
  @abi64_32 0x02000000
  @abi_mask 0xFF000000

  @spec parse(integer, integer) :: [String.t()]
  def parse(type_int, subtype_int) do
    type_int
    |> type()
    |> (&{&1, subtype(subtype_int, &1)}).()
    |> (fn {type, subtype} ->
          [
            "type:    #{type}",
            "subtype: #{subtype}"
          ]
        end).()
  end

  def format(%{type: type, subtype: subtype}) when is_binary(subtype) do
    fmt(type) <> subtype
  end

  defp fmt(:vax), do: "DEC VAX"
  defp fmt(:mc68k), do: "Motorola 68K"
  defp fmt(:mc88k), do: "Motorola 88K"
  defp fmt(:hp_pa), do: "HP/PA"
  defp fmt(:aarch64), do: "AArch64"
  defp fmt(:arm64_32), do: "Arm64-32"
  defp fmt(:arm), do: "Arm"
  defp fmt(:sparc), do: "SPARC"
  defp fmt(:i860), do: "80860"
  defp fmt(:alpha), do: "Alpha"
  defp fmt(:power), do: "PowerPC"
  defp fmt(:power64), do: "PowerPC-64"
  defp fmt(:mc98000), do: "PowerPC MC98000"
  defp fmt(intel_or_any), do: intel_or_any.to_string()

  defp subtype(int, :mc68k) do
    case int do
      1 -> "Generic"
      2 -> "68040"
      3 -> "68030"
      _ -> "Unknown#{int}"
    end
  end

  defp subtype(int, :mc88k) do
    case int do
      0 -> "Generic"
      1 -> "88100"
      2 -> "88110"
      _ -> "Unknown#{int}"
    end
  end

  defp subtype(int, :vax) do
    case int do
      0 -> "Generic"
      1 -> "11/780"
      2 -> "11/785"
      3 -> "11/750"
      4 -> "11/730"
      5 -> "MicroVAX I"
      6 -> "MicroVAX II"
      7 -> "8200"
      8 -> "8500"
      9 -> "8600"
      10 -> "8650"
      11 -> "8800"
      12 -> "MicroVAX III"
      _ -> "Unknown#{int}"
    end
  end

  defp subtype(int, :mips) do
    case int do
      0 -> "Generic"
      1 -> "R2300"
      2 -> "R2600"
      3 -> "R2800"
      4 -> "R2000a"
      5 -> "R2000"
      6 -> "R3000a"
      7 -> "R3000"
      _ -> "Unknown"
    end
  end

  defp subtype(int, :mc98000) do
    case int do
      0 -> "Generic"
      1 -> "MC98601"
      _ -> "Unknown"
    end
  end

  defp subtype(int, :hp_pa) do
    case int do
      0 -> "7100"
      2 -> "7100LC"
      _ -> "Unknown"
    end
  end

  defp subtype(int, :aarch64) do
    case int do
      0 -> "Generic"
      1 -> "Armv8-A"
      2 -> "Arm64e"
      _ -> "Unknown"
    end
  end

  defp subtype(int, :arm64_32) do
    case int do
      0 -> "Generic"
      1 -> "Armv8-A"
      _ -> "Unknown"
    end
  end

  defp subtype(int, :arm) do
    case int do
      0 -> "Generic"
      _ -> "Unknown"
    end
  end

  defp subtype(int, :sparc) do
    case int do
      0 -> "Generic"
      _ -> "Unknown"
    end
  end

  defp subtype(int, :i860) do
    case int do
      0 -> "Generic"
      1 -> "i860"
      _ -> "Unknown"
    end
  end

  defp subtype(int, :alpha) do
    case int do
      0 -> "Generic"
      _ -> "Unknown"
    end
  end

  defp subtype(int, :power), do: power_subtype(int)
  defp subtype(int, :power64), do: power_subtype(int)

  defp power_subtype(int) do
    case int do
      0 -> "(Generic)"
      1 -> "601"
      2 -> "602"
      3 -> "603"
      4 -> "603e"
      5 -> "603ev"
      6 -> "604"
      7 -> "604e"
      8 -> "620"
      9 -> "750 (G3)"
      10 -> "7400 (G4)"
      11 -> "7450 (G4e)"
      100 -> "970 (G5)"
      _ -> "(Unknown)"
    end
  end

  defp type(-1), do: :any

  defp type(int) do
    abi =
      case int &&& @abi_mask do
        @abi64 -> :_64
        @abi64_32 -> :_64_32
        _ -> nil
      end

    type = int &&& ~~~@abi_mask

    case {type, abi} do
      {1, _} ->
        :vax

      {6, _} ->
        :mc68k

      {7, :_64} ->
        :x86_64

      {7, _} ->
        :x86

      {8, _} ->
        :mips

      {10, _} ->
        :mc98000

      {11, _} ->
        :hp_pa

      {12, :_64} ->
        :aarch64

      {12, :_64_32} ->
        :arm64_32

      {12, _} ->
        :arm

      {13, _} ->
        :mc88k

      {14, _} ->
        :sparc

      {15, _} ->
        :i860

      {16, _} ->
        :alpha

      {18, :_64} ->
        :power64

      {18, _} ->
        :power

      _ ->
        :unknown
    end
  end
end
