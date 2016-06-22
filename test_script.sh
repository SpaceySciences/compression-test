#!/bin/bash

itnum=$1 # gets the first command line arg as tentative iteration number
stype=$2 # gets the second cmd line arg as tentative list of start types
compalg=$3 # gets the third cmd line arg as tentative path to compression alg.
etypes=$4 # gets the fourth cmd line arg as tentative list of end types

# temporarily overwrite the input until string parsing to a list is implemented
etypes=("j2k" "j2c" "jp2")

# if the first arg is not a number between 9 and F then error
# or if there are more or less than 4 command line args, then error
if [[ ("$itnum" -lt 0) || ("$itnum" -gt 9) || $# -gt 4  || $# -lt 3 ]]; then
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

# if there is not an executable file at the path passed in, error
if [[ !(-x "$compalg") ]]; then
  # print error
  echo "Error: the compression algorithm you provided is not an executable file"
  # exit with status of 1
  exit 1
fi

# TODO -- List parsing of output files
#         For now will just use static list of three output file types:
#           - .j2k
#           - .j2c
#           - .jp2
# if there is not a valid file type as output type, error
#if [[ ]]; then
#  # print usage error
#  echo "Error: Please enter a valid output file type. Valid file types are: j2k, j2c, jp2"
#  # exit with status of 1
#  exit 1
#fi

# if all the files in the input path are not readable or there are no files in
# the directory, error
for filename in ./img/in/it-$itnum/$stype/*; do
  if [[ !(-r "$filename") ]]; then
    # print error
    echo "Error: not all input files in path ./img/in/it-$itnum/$stype/ are readable"
    # exit with status of 1
    exit 1
  fi
done

# if there is not an info.csv file, error
if [[ !(-r "./img/in/it-$itnum/$stype/info.csv") ]]; then
  # print error
  echo "Error: an info.csv file has not been provided"
  # exit with error of 1
  exit 1
fi

# make dirs for outputs
mkdir ./img/out/it-$itnum
mkdir ./img/out/it-$itnum/$stype

# csv set up
echo "\"in_title\" \"in_file_size\" \"out_title\" \"out_file_size\" \"description\"" > ./img/out/it-$itnum/$stype/info.csv

# run the compression algorithm on the images
num=0
for filename in ./img/in/it-$itnum/$stype/*.$stype; do
  in_filesize=$(wc -c < "$filename")

  $compalg -i $filename -o ./img/out/it-$itnum/$stype/$num\.j2k
  out_filesize=$(wc -c < "./img/out/it-$itnum/$stype/$num.j2k")
  echo "$filename $in_filesize ./img/out/it-$itnum/$stype/$num.j2k $out_filesize" >> ./img/out/it-$itnum/$stype/info.csv

  $compalg -i $filename -o ./img/out/it-$itnum/$stype/$num\.j2c
  out_filesize=$(wc -c < "./img/out/it-$itnum/$stype/$num.j2c")
  echo "$filename $in_filesize ./img/out/it-$itnum/$stype/$num.j2c $out_filesize" >> ./img/out/it-$itnum/$stype/info.csv

  $compalg -i $filename -o ./img/out/it-$itnum/$stype/$num\.jp2
  out_filesize=$(wc -c < "./img/out/it-$itnum/$stype/$num.jp2")
  echo "$filename $in_filesize ./img/out/it-$itnum/$stype/$num.jp2 $out_filesize" >> ./img/out/it-$itnum/$stype/info.csv

  num=`expr $num + 1`
done



# get the filename and file size for each file in the specified folder and
# output to the csv
for filename in ./img/in/it-$itnum/$stype/*.$stype; do
  filesize=$(wc -c < "$filename")
  echo "$filename $filesize" >> ./img/in/it-$itnum/$stype/info.csv
done
