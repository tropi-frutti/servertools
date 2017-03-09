#!/bin/bash
if [ -f telefoncheck.pid ]
then
  echo "telefoncheck.pid already there"
  # check if it is older than 60 minutes
  if [ "$(./busybox find telefonckeck.pid -mmin +60)" ] 
  then
    echo "pid older than 60 minutes assuming process no longer running"
  else
    echo "pid younger than 60 minutes assuming old process still runnng"
    exit
  fi
fi

echo $$ > telefoncheck.pid 

rm dusicon.gif
wget -nv --no-check-certificate --output-document=dusicon.gif https://www.dus.net/dusicon.php?a=277521d0a1920678a140d04beada93d6
if [ -f dusicon.gif ]
then
  echo "found dusicon.gif"
  duout=`du -b dusicon.gif`
  a=( $duout )
  filesizedown=843
  filesizeup=1607
  if [ "${a[0]}" -eq "$filesizedown" ]
  then
    if [ ! -f downmailsent.touch ]
    then
      rm upmailsent.touch
      touch downmailsent.touch
      curl "http://familie-steiner.net/mail.php?subject=Telefon%20getrennt"
    fi
  elif [ "${a[0]}" -eq "$filesizeup" ]
  then
    if [ ! -f upmailsent.touch ]
    then
      rm downmailsent.touch
      touch upmailsent.touch
      curl "http://familie-steiner.net/mail.php?subject=Telefon%20verbunden"
    fi
  else
    curl "http://familie-steiner.net/mail.php?subject=Unknown%20filesize%20${a[0]}"
  fi
else
  curl "http://familie-steiner.net/mail.php?subject=Telefonstatus%20nicht%20ermittelbar"
fi

#./busybox sleep 90
rm telefoncheck.pid