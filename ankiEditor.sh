#!/bin/bash
SRCDIR=/mnt/d/Downloads
DSTDIR=/mnt/d/Documents/Japanese/Anki
WINDIR='D:\Documents\Japanese\Anki\'
nohup "/mnt/c/Program Files/Anki/anki.exe" >/dev/null 2>&1 &
sleep 5
for i in $(find $SRCDIR -type f -name '*.apkg');
do
    FILE=$(echo $i | cut -d'/' -f5)
    echo "Processing $FILE...";
    unzip -q $i;
    rm $i;
    sed -i 's/20px/70px/' collection.anki2;
    echo '{}' > media;
    zip -q $FILE collection.anki2 media;
    rm collection.anki2 media;
    echo "Processing $FILE complete.";
    echo "Moving $FILE into $DSTDIR";
    mv $FILE $DSTDIR;
    echo "Importing $FILE into Anki";
    "/mnt/c/Program Files/Anki/anki.exe" ""$WINDIR""$FILE"";
done
killall anki.exe >/dev/null 2>&1
