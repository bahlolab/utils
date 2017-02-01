#!/usr/local/bin/bash

# Download files in the specified input file using aria2c.

# Options used
# i: input file containing URIs.
# c: continue downloading file.
# x: multiple connections.
# s: split file so multiple connections.
# j: max num of parallel downloads.
# file-allocation: pre-allocate file space.

PWD=foobar
UNAME=popeye

module load aria2

aria2c \
  -x10 \
  -j10 \
  -s16 \
  --file-allocation=none \
  --ftp-user=${UNAME} \
  --ftp-passwd=${PWD} \
  -i urls.txt

#### the end
