defmodule Machxir.MachO.LoadCommand.BuildVersion.Tool do
  alias Machxir.ByteCrawler

  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid, opt) do
    tool = ByteCrawler.read_uint32(pid) |> tool(opt)
    version = ByteCrawler.read_uint32(pid)

    [
      "tool:    #{tool}",
      "version: #{version}"
    ]
  end

  defp tool(int, :format), do: int
  defp tool(int, :describe), do: describe_tool(int)

  defp describe_tool(int) do
    case int do
      1 -> "clang"
      2 -> "Swift"
      3 -> "ld"
      _ -> "Unknown(#{int})"
    end
  end
end
