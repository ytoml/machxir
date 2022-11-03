defmodule Machxir.MachO.LoadCommand.BuildVersion do
  @moduledoc """
  Parsing LC_BUILD_VERSION.
  """

  alias Machxir.ByteCrawler
  alias Machxir.MachO.LoadCommand.BuildVersion.Tool

  @spec parse(pid, :describe | :format) :: [
          String.t() | list
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid, opt) do
    platform = ByteCrawler.read_uint32(pid) |> platform(opt)
    minos = ByteCrawler.read_uint32(pid)
    ntools = ByteCrawler.read_uint32(pid)

    build_tool_versions =
      Enum.map(
        1..ntools//1,
        fn n ->
          ["Build tool version #{n}:", Tool.parse(pid, opt)]
        end
      )

    [
      "minos:    #{minos}",
      "platform: #{platform}",
      "ntools:   #{ntools}",
      build_tool_versions
    ]
  end

  defp platform(int, :format), do: int

  defp platform(int, :describe) do
    case(int) do
      1 -> "macOS"
      2 -> "iOS"
      3 -> "tvOS"
      4 -> "watchOS"
      5 -> "bridgeOS"
      6 -> "Mac Catalyst"
      7 -> "iOS Simulator"
      8 -> "tvOS Simulator"
      9 -> "watchOS Simulator"
      10 -> "DriverKit"
      _ -> "Unknown(#{int})"
    end
  end
end
