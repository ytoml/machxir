defmodule Machxir.MachO.LoadCommand.CodeSignature do
  @moduledoc """
  Parsing LC_CODE_SIGNATURE.
  """

  alias Machxir.ByteCrawler

  @spec parse(pid, any) :: [
          String.t()
        ]
  @doc """
  `pid` must be of the `ByteCrawler`server.
  """
  def parse(pid, _) do
    sig = ByteCrawler.take_all(pid)

    sig_display =
      if byte_size(sig) <= 10 do
        sig
      else
        <<s::binary-size(10), _::binary>> = sig
        s <> "..."
      end

    ["signature: #{sig_display}"]
  end
end
