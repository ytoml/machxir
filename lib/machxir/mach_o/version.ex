defmodule Machxir.MachO.Version do
  import Bitwise

  def version_string(int) do
    major = (int &&& 0xFFFF0000) >>> 16
    minor = (int &&& 0x0000FF00) >>> 8
    patch = int &&& 0x000000FF
    "#{major}.#{minor}.#{patch}"
  end
end
