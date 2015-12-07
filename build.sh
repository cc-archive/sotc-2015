#!/bin/bash
git clone https://github.com/creativecommons/sotc-215.git
mv sotc-215/data.mdwn .
rm -rf sotc-215
rm xx*
rm cc*.html
rm translat*.html
csplit sotc.md '/-----/' {*}
for file in xx*
do
    ## We use this prefix for our filenames, also in CSS.
    PREFIX=cc-sotc-2015-$file
    ## Ignore the initial two lines of the file, which are a page break
    tail -n +2 "$file" > "$PREFIX.mdwn"
    ## Get the first line of the file, strip the Markdown and pass to pandoc
    TITLE=$(echo $(head -n 4 $PREFIX.mdwn) | perl -pe 's/## //g' | perl -pe 's/{.bb}//g' | perl -pe 's/{.impact .img-policy}//g'| perl -pe 's/{.impact}//g' |  perl -pe 's/{.by}//g' | perl -pe 's/{.bbs}//g' | sed -e 's/<[^>]*>//g')
    echo $TITLE
    pandoc --smart "$PREFIX.mdwn" -T $PREFIX -V "pagetitle: $TITLE" -V "title: $TITLE" -w html5 -o "$PREFIX.html" --template template.html
    rm "$file"
    rm "$PREFIX.mdwn"
done

pandoc --smart "sotc.md" -T $PREFIX -V "pagetitle: $TITLE" -V "title: $TITLE" -w html5 -o "onepage.html" --template template.html

pandoc --smart "mini.md" -T $PREFIX -V "pagetitle: $TITLE" -V "title: $TITLE" -w html5 -o "mini.html" --template template.html

pandoc --smart "data.mdwn" --toc -V "pagetitle: Data" -V "title: Data" -w html5 -o "data.html" --template data-template.html

cd translations
echo "<ol>" > translation-index.html
for langfile in *.csv
do
    perl ../translate.pl $langfile ../translation.md > $langfile.md
    TITLE=$(echo $(head -n 2 $langfile.md) | perl -pe 's/## //g' | perl -pe 's/{.bb}//g' | perl -pe 's/{.impact}//g'|  perl -pe 's/{.by}//g' | perl -pe 's/{.bbs}//g' | sed -e 's/<[^>]*>//g')

    pandoc --smart "$langfile.md" -T $langfile -V "pagetitle: $TITLE" -V "title: $TITLE" -w html5 -o "../translation-$langfile.html" --template ../template.html

    echo "<li><a href='translation-$langfile.html'>$langfile</a></li>" >> ../translation-index.html
    
done

cd ..



rsync -arR *.css *.md *.html img/ mattl@labs.creativecommons.org:~/public_html/sotc-2015-mattl/

git add .
git commit -m "Updates"
