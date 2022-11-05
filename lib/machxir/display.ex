defmodule Machxir.Display do
  def display(parsed, n_indents \\ 2) do
    indent = String.duplicate(" ", n_indents)
    # manual loop for zero indentation
    for e <- parsed do
      print(e, "", indent)
    end
  end

  defp print(e, cur_indent, _add_indent) when is_binary(e) do
    IO.puts(cur_indent <> e)
  end

  defp print(l, cur_indent, add_indent) when is_list(l) do
    indent = add_indent <> cur_indent

    for e <- l do
      print(e, indent, add_indent)
    end
  end
end
