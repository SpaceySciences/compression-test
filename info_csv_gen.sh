#!/bin/bash

itnum=$1 # gets the first command line arg as tentative iteration number
stype=$2 # gets the second cmd line arg as tentative list of start types

# if the first arg is not a number between 9 and F then error
# or if there are more or less than 4 command line args, then error
if [[ ("$itnum" -lt 0) || ("$itnum" -gt 9) || $# -gt 2  || $# -lt 2 ]]; then
  # print usage error redirected to the error
  echo "Usage: test_script.sh <iteration number 0-9> [<start types>] \"<path to compression algorithm>\" [<end types>]"
  # exit with status of 1
  exit 1
fi

# if there is not a valid file type as input type, error
if [[ !(${2:0:3} == "png" || ${2:0:3} == "tif" || ${2:0:3} == "bmp" || ${2:0:3} == "raw") ]]; then
  # print usage error
  echo "Error: Please enter a valid input file type. Valid file types are: png, raw, tif, bmp"
  # exit with status of 1
  exit 1
fi

# csv set up
echo "\"title\" \"file_size\" \"description\"" > ./img/in/it-$itnum/$stype/info.csv


# get the filename and file size for each file in the specified folder and
# output to the csv
for filename in ./img/in/it-$itnum/$stype/*.$stype; do
  filesize=$(wc -c < "$filename")
  echo "$filename $filesize" >> ./img/in/it-$itnum/$stype/info.csv
done
