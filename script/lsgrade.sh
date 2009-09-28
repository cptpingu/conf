#!/bin/sh

TMP="/tmp/gradetmp"
SED="sed"
which gsed >/dev/null 2>&1 && SED="gsed"

min=0
max=0
total=0
nb=`\ls -l *.xml 2> /dev/null | wc -l`

if [ $nb -le 0 ]; then
    echo "No xml found in the given directory"
    exit 1
fi

echo > $TMP
for login in `\ls *.xml`; do
    echo -n "${login%.xml} : "
    grade=`cat $login | grep '<grade>' | $SED -r 's/<grade>(.*)<\/grade>/\1/g'`
    if [ `echo "scale=2; $grade > $max" | bc` -ne 0 ]; then
	max=$grade
    fi
    if [ `echo "scale=2; $grade < $min" | bc` -ne 0 ]; then
	min=$grade
    fi
    total=`echo "scale=2;$total + $grade" | bc`
    echo "$grade" >> $TMP
    echo $grade
done

median=`cat $TMP | sort -n | head -n $(($nb / 2)) | tail -n 1`
total=`echo "scale=2;$total / $nb" | bc`
echo
echo "Mean:   $total/20"
echo "Median: $median/20"
echo "Min:    $min/20"
echo "Max:    $max/20"
rm -f $TMP
