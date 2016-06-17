# JPEG Compression Algorithm Comparison Testing

## Purpose
The purpose of this experiment is to choose a compression algorithm for MOCI
Sat's images to be transmitted to the ground station. In addition to the
compression algorithm itself, we will also need to choose the best starting file
type and ending file type that will result in the best quality of image balanced
against the size of the file and the time required to convert between the file
types.

## Overview
This program will gather data regarding the size of compressed images generated
by different compression algorithms and the time taken to do so. The purpose of
this is to choose a compression algorithm to use on the satellite images taken
by MOCI sat. This bash script will take in many images of varying file sizes and
containing varying geographic features (such as images of the ocean, coastline,
and land, including forests, planes, and cities). The compression algorithm will
then be run on each image, and the resulting file size and runtime will be
written to the data csv. This csv will contain all the file sizes and runtimes
for each file, each compression algorithm, and each start and end file type,
which can then be graphed and compared.

## Compression Algorithms Tested
##### Test Run 1 -- June 2016
The first two algorithms compared with be two versions of OpenJPEG.
OpenJPEG, version 1 -- ocomp -- https://github.com/uclouvain/openjpeg/
OpenJPEG, version 2 -- pcomp -- https://github.com/planetlabs/openjpeg/

## File Types Used
##### Test Run 1 -- June 2016
###### Start Types
We will start with the following types, which will be converted into each end
type.
- .png
- .tif
- .bmp
- .raw

###### End Types
We will convert each starting type, using each algorithm, into the following
types.
- .j2k
- .j2c
- .jp2

## Test Out CSV
The bash script will create a .csv file that will contain the starting file's
information, especially the file size and a description of the image.
