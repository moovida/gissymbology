#! /bin/bash
#
# by Andrea Antonello (www.hydrologis.com)
#
# Script to 
# 1 - donwload latest changes from mercurial repo
# 2 - generate png images from svg (requires inkscape installed)
# 3 - generate for every image a record in the table in the wiki page
# 4 - uploads changes to repo, assuming that you have permissions to do so


# retrieve latest changes
hg pull -u


# generate images and wiki page
BASE=symbology/svg
WIKIFILE=Test.wiki

SVGREPO=http://wiki.gissymbology.googlecode.com/hg/symbology/svg

echo "#summary some test images to start" > $WIKIFILE
echo "" >> $WIKIFILE
echo "" >> $WIKIFILE
echo "|| Name/code || Image || Download svg ||" >> $WIKIFILE


for i in $BASE/*.svg
do
   SVGNAME=`basename $i`
   BASENAME=${SVGNAME%%.svg}
   PNGNAME=$BASENAME.png
   inkscape -f $i -e $BASE/$PNGNAME -w 48
   echo -n "|| $BASENAME || " >> $WIKIFILE
   echo -n "<p align=\"center\"><img src=\"$SVGREPO/$PNGNAME\"/></p>" >> $WIKIFILE
   echo "|| [$SVGREPO/$SVGNAME $SVGNAME] ||" >> $WIKIFILE
done

# push changes up
hg add
hg commit -m "new images"
hg push
