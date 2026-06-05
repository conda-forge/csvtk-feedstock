#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

cd csvtk
go build -buildmode=pie -trimpath -o=${PREFIX}/bin/csvtk -ldflags="-s -w -X main.Version=${PKG_VERSION}"
go-licenses save . --save_path=license-files --ignore github.com/ajstarks/svgo --ignore github.com/golang/freetype/raster

# Install shell completions
mkdir -p ${PREFIX}/share/zsh/site-functions ${PREFIX}/share/bash-completion/completions ${PREFIX}/share/fish/vendor_completions.d
${PREFIX}/bin/csvtk completion --shell zsh --file ${PREFIX}/share/zsh/site-functions/_csvtk
${PREFIX}/bin/csvtk completion --shell bash --file ${PREFIX}/share/bash-completion/completions/csvtk
${PREFIX}/bin/csvtk completion --shell fish --file ${PREFIX}/share/fish/vendor_completions.d/csvtk.fish

# Create a symbolic link named tsvtk.
# When invoked as "tsvtk", csvtk will automatically enable the "-t/--tabs" flag.
cd ${PREFIX}/bin/
ln -s csvtk tsvtk
