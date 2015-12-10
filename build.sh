#!/bin/bash
# Build script for SOTC 2015, if you can figure out how this works, good luck
# Released under CC0
#
# Thanks to the creators of git, perl, GNU csplit, pandoc, markdown,
# perl, coreutils, fileutils, Inkscape, GIMP and of course, GNU Emacs

rm xx*
rm cc*.html
rm translat*.html
csplit sotc.md '/-----/' {*}
for file in xx*
do
    ## We use this prefix for our filenames, also in CSS.
    PREFIX=cc-sotc-2015-$file
    ## Ignore the initial two lines of the file, which are a page break
    tail -n +11 "$file" > "$PREFIX.mdwn"
    ## Get the first line of the file, strip the Markdown and pass to pandoc
    TITLE=$(echo $(head -n 4 $PREFIX.mdwn) | perl -pe 's/## //g' | perl -pe 's/{.bb}//g' | perl -pe 's/{.impact .img-policy}//g'| perl -pe 's/{.impact}//g' |  perl -pe 's/{.by}//g' | perl -pe 's/{.bbs}//g' | sed -e 's/<[^>]*>//g')
    echo $TITLE
    pandoc --smart "$PREFIX.mdwn" -T $PREFIX -V "pagetitle: $TITLE" -V "title: $TITLE" -w html5 -o "$PREFIX.html" --template template.html
done

pandoc --smart "sotc.md" -T $PREFIX -V "pagetitle: $TITLE" -V "title: $TITLE" -w html5 -o "index.html" --template home.html

pandoc --smart "mini.md" -T $PREFIX -V "pagetitle: $TITLE" -V "title: $TITLE" -w html5 -o "mini.html" --template template.html

pandoc --smart "data.mdwn" --toc -V "pagetitle: Data" -V "title: Data" -w html5 -o "data.html" --template data-template.html

echo "<ol>" > translation-index.html
cd translations
for langfile in *.csv
do
    perl ../translate.pl $langfile ../translation.md > $langfile.md
    TITLE=$(echo $(head -n 2 $langfile.md) | perl -pe 's/## //g' | perl -pe 's/{.bb}//g' | perl -pe 's/{.impact}//g'|  perl -pe 's/{.by}//g' | perl -pe 's/{.bbs}//g' | sed -e 's/<[^>]*>//g')

    pandoc --smart "$langfile.md" -T $langfile -V "pagetitle: $TITLE" -V "title: $TITLE" -w html5 -o "../translation-$langfile.html" --template ../template-i18n.html

    echo "<li><a href='translation-$langfile.html'>$langfile</a></li>" >> ../translation-index.html
    
done
#rm *.md
cd ..



#rsync -arR *.css *.md *.html img/ mattl@labs.creativecommons.org:~/public_html/sotc-2015-mattl/

git add .
git commit -m "Updates"
