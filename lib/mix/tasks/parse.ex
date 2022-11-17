defmodule Mix.Tasks.Parse do
  @shortdoc "Parse Mach-O file"
  use Mix.Task
  alias Machxir.Display

  def run([]), do: IO.puts("Usage: mix parse [file] [OPTIONS]
  --verbose, -v   rich output
  --describe, -d  alias of --verbose
    ")

  def run(args) do
    {flags, files, []} =
      OptionParser.parse(args,
        switches: [describe: :boolean, verbose: :boolean],
        aliases: [d: :describe, v: :verbose]
      )

    mode = if flags[:describe] || flags[:verbose], do: :describe, else: :format

    case files do
      [] ->
        IO.puts(:standard_error, "Error: Please provide filename.")

      [file] ->
        case File.read(file) do
          {:ok, binary} ->
            Machxir.parse(binary, mode)
            |> Display.display()

          {:error, posix} ->
            IO.puts(:standard_error, "Error: Reading file failed(#{inspect(posix)}).")
        end

      _ ->
        IO.puts(:standard_error, "Error: Only single file parsing is supported.")
    end
  end
end
