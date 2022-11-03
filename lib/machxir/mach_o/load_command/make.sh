#!/bin/bash

array=($(ls))

for filename in ${array[@]}; do
  if [[ ! $filename == *".ex" ]]; then
    continue
  fi
  cmd=${filename%.ex}
  modname=$(echo ${cmd} | perl -nE 'say join "", map {ucfirst lc} split /[^[:alnum:]]+/')
  signature=$(echo ${cmd} | perl -nE 'say join "_", map {uc} split /[^[:alnum:]]+/')
  echo "defmodule Machxir.MachO.LoadCommand.${modname} do
  @moduledoc \"\"\"
  Parsing LC_${signature}.
  \"\"\"

  alias Machxir.ByteCrawler

  @doc \"\"\"
  \`pid\` must be of the \`ByteCrawler\`server.
  \"\"\"
  def parse(pid) do
  end
end
" >${filename}
done
