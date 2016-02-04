# Use the Mac open command - on your Linux box!
Written by Rick Tankard

With this script in your path, along with setting the environment variables OPEN_MYMAC and OPEN_PATH_MAPS_FILE you can use the open command on the Linux boxes and get the same affect as if you'd used the open command on your local Mac. 

To get the best usage out of this script you will need to correctly configure the file specified by OPEN_PATH_MAPS_FILE, which is tab delimited with each first column as the Linux path, and the second column pointing to the same path avaliable on your Mac. Lines starting with # or empty are ignored.
