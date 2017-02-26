Download Big Data with aria2
============================
In short: use aria2 if you want to download big big data. See bash script in this directory.

I have been downloading a huge amount of data (> 5TB) over the past few weeks.
I downloaded the first few batches using the 'curl' command but found it to be
quite a pain, especially when downloading big BAM files (>150GB). The
connection to the download server would often get interrupted, resulting in
failed downloads and even corrupted files e.g. I noticed some FASTQ and BAM
files had an error message *inside* the actual file. Using 'curl -C -' you
could resume the interrupted file transfer, but the file would sometimes be
stuffed due to -see previous sentence-. Checking the md5 hash of your
downloaded file is an absolute must for this reason.

I've recently started using aria (module was added to our servers recently -
see <https://aria2.github.io/manual/en/html/aria2c.html>) and I've found it to be
much much much better. I think it automatically resumes from a failed download,
and its ability to split downloads into multiple connections means that it's
really quick.
One of the quirks with it though is that it needs a file containing the url
of each file that needs to be downloaded (i.e. it can't download recursively
given simply a folder name). Some places provide this, but other places might
not. You'll
probably need to construct this yourselves. Ask me if you don't know how to do
this. I probably won't be able to help but it'll be fun nevertheless... Maybe
you can hack into the ftp site through the command line and use `find` like
it is suggested here:
<http://stackoverflow.com/questions/98224/how-to-list-directory-content-of-remote-ftp-recursively/98234#98234>

Below I'm showing a script that I'm using to download from AGRF's ftp site.
Make sure you load the module first.


```bash
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
```

