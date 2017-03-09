#!/bin/bash
cd servertools/alivecheck/internet
if [ -f internetcheck.pid ]
then
  echo "internetcheck.pid already there"
  # check if it is older than 60 minutes
if [ "$(~/busybox find internetcheck.pid -mmin +60)" ] 
  then
    echo "pid older than 60 minutes assuming process no longer running"
  else
    echo "pid younger than 60 minutes assuming old process still runnng"
    exit
  fi
fi

echo $$ > internetcheck.pid 

rm -f index.html
wget -T 10 -t 1 -nv --no-check-certificate https://steiner.spdns.eu
if [ -f index.html ]
then
    if [ ! -f iupmailsent.touch ]
    then
      rm idownmailsent.touch
      touch iupmailsent.touch
      curl "http://familie-steiner.net/mail.php?subject=Internet%20verbunden"
    fi
else
    if [ ! -f idownmailsent.touch ]
    then
      rm iupmailsent.touch
      touch idownmailsent.touch
      curl "http://familie-steiner.net/mail.php?subject=Internet%20getrennt"
    fi
fi

#./bu