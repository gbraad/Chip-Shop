#!/bin/bash

bundle install
bundle update

rm -dfr _site
rm -dfr pod

jekyll build

mkdir -p pod/pdf/cards

for filename in _cards/*.md; do
  echo $filename

  pandoc --from=markdown+yaml_metadata_block --template _layouts/cards.latex -o pod/pdf/cards/"$(basename "$filename" .md)".pdf --latex-engine=xelatex $filename
done

pdfjam _site/pdf/cards/*.pdf --no-landscape --frame true --nup 3x3 --delta "0.2cm 0.2cm" --noautoscale=true --outfile pod/cards_complete.pdf
